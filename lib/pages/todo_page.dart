import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  List<Map<String, dynamic>> _tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTasks = prefs.getStringList('todo_tasks') ?? [];
    setState(() {
      _tasks = savedTasks
          .map((task) {
            try {
              return jsonDecode(task);
            } catch (_) {
              return null;
            }
          })
          .whereType<Map<String, dynamic>>()
          .toList();
    });
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskStrings = _tasks.map((task) => jsonEncode(task)).toList();
    await prefs.setStringList('todo_tasks', taskStrings);
  }

  void _addTaskDialog() {
    final TextEditingController titleController = TextEditingController();
    DateTime? selectedDate;
    String? selectedCategory;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("New Task"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Task Title",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: selectedCategory,
                hint: const Text("Select Category"),
                items: ['Work', 'Personal', 'Errands', 'Other']
                    .map((cat) => DropdownMenuItem(
                          value: cat,
                          child: Text(cat),
                        ))
                    .toList(),
                onChanged: (value) {
                  selectedCategory = value;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () async {
                  final now = DateTime.now();
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: now,
                    firstDate: now,
                    lastDate: DateTime(now.year + 5),
                  );
                  if (picked != null) {
                    setState(() => selectedDate = picked);
                  }
                },
                icon: const Icon(Icons.calendar_today),
                label: Text(selectedDate == null
                    ? "Pick Due Date"
                    : DateFormat.yMMMd().format(selectedDate!)),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              final title = titleController.text.trim();
              if (title.isNotEmpty) {
                final task = {
                  'title': title,
                  'dueDate': selectedDate?.toIso8601String(),
                  'category': selectedCategory ?? "Uncategorized",
                  'completed': false,
                };
                setState(() {
                  _tasks.add(task);
                });
                _saveTasks();
                Navigator.pop(context);
              }
            },
            child: const Text("Add Task"),
          )
        ],
      ),
    );
  }

  void _toggleTask(int index) {
    setState(() {
      _tasks[index]['completed'] = !_tasks[index]['completed'];
    });
    _saveTasks();
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
    _saveTasks();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bg = theme.colorScheme.background;
    final primary = theme.colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: const Text("To-Do List"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primary, bg],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addTaskDialog,
        icon: const Icon(Icons.add),
        label: const Text("New Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _tasks.isEmpty
            ? const Center(child: Text("No tasks yet. Add one!"))
            : ListView.separated(
                itemCount: _tasks.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final task = _tasks[index];
                  return ListTile(
                    title: Text(
                      task['title'],
                      style: TextStyle(
                        decoration: task['completed']
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    subtitle: Text(
                      "${task['category']} • ${task['dueDate'] != null ? DateFormat.yMMMd().format(DateTime.parse(task['dueDate'])) : 'No due date'}",
                    ),
                    leading: Checkbox(
                      value: task['completed'],
                      onChanged: (_) => _toggleTask(index),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _deleteTask(index),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
