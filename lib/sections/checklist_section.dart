import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChecklistSection extends StatefulWidget {
  const ChecklistSection({super.key});

  @override
  State<ChecklistSection> createState() => _ChecklistSectionState();
}

class _ChecklistSectionState extends State<ChecklistSection> {
  final List<String> _items = [];
  final Set<int> _checkedItems = {};
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadChecklist();
  }

  // Load the checklist from SharedPreferences
  // This method is called when the widget is first created
  Future<void> _loadChecklist() async {
    final prefs = await SharedPreferences.getInstance();
    final savedItems = prefs.getStringList('checklist_items') ?? [];
    final checkedIndices = prefs.getStringList('checklist_checked') ?? [];

    setState(() {
      _items.addAll(savedItems);
      _checkedItems.addAll(checkedIndices.map(int.parse));
    });
  }

  // Save the checklist to SharedPreferences
  // This method is called whenever an item is added or removed
  Future<void> _saveChecklist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('checklist_items', _items);
    await prefs.setStringList(
        'checklist_checked', _checkedItems.map((e) => e.toString()).toList());
  }

  // Add an item to the checklist
  // This method is called when the user submits the text field or presses the add button
  void _addItem(String item) {
    if (item.trim().isEmpty) return;
    setState(() {
      _items.add(item.trim());
      _controller.clear();
    });
    _saveChecklist();
  }

  // Remove an item from the checklist
  // This method is called when the user swipes an item to delete it
  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
      _checkedItems.remove(index);
      // Adjust checked indices
      _checkedItems
          .removeWhere((i) => i >= _items.length); // Avoid overflow errors
    });
    _saveChecklist();
  }

  // Toggle the checked state of an item
  // This method is called when the user taps on an item
  void _toggleItem(int index) {
    setState(() {
      _checkedItems.contains(index)
          ? _checkedItems.remove(index)
          : _checkedItems.add(index);
    });
    _saveChecklist();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onBackground;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Checklist",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.2),

          const SizedBox(height: 12),

          // Input
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: "Add an item...",
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onSubmitted: _addItem,
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () => _addItem(_controller.text),
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                ),
                child: const Text("Add"),
              ),
            ],
          ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1),

          const SizedBox(height: 20),

          // Items
          ..._items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final isChecked = _checkedItems.contains(index);

            return Dismissible(
              key: ValueKey(item + index.toString()),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 24),
                color: Colors.redAccent.withOpacity(0.8),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (_) => _removeItem(index),
              child: GestureDetector(
                onTap: () => _toggleItem(index),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: isChecked
                        ? theme.colorScheme.primary.withOpacity(0.1)
                        : theme.colorScheme.surface.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: isChecked
                          ? theme.colorScheme.primary
                          : Colors.grey.withOpacity(0.3),
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      AnimatedContainer(
                        duration: 250.ms,
                        height: 22,
                        width: 22,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isChecked
                              ? theme.colorScheme.primary
                              : Colors.transparent,
                          border: Border.all(
                            color: isChecked
                                ? theme.colorScheme.primary
                                : Colors.grey,
                            width: 2,
                          ),
                        ),
                        child: isChecked
                            ? const Icon(Icons.check,
                                size: 16, color: Colors.white)
                            : null,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          item,
                          style: TextStyle(
                            fontSize: 16,
                            color: isChecked
                                ? theme.colorScheme.primary
                                : textColor.withOpacity(0.9),
                            decoration:
                                isChecked ? TextDecoration.lineThrough : null,
                            fontWeight:
                                isChecked ? FontWeight.w600 : FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ).animate().fadeIn(delay: (index * 80).ms).slideY(begin: 0.08),
            );
          }),
        ],
      ),
    );
  }
}
