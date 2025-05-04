import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  final List<String> _tasks = [];
  final Set<int> _completedTasks = {};
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTasks = prefs.getStringList('todo_tasks') ?? [];
    final savedCompleted = prefs.getStringList('todo_completed') ?? [];

    setState(() {
      _tasks.addAll(savedTasks);
      _completedTasks.addAll(savedCompleted.map(int.parse));
    });
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('todo_tasks', _tasks);
    await prefs.setStringList(
        'todo_completed', _completedTasks.map((e) => e.toString()).toList());
  }

  void _addTask(String task) {
    if (task.trim().isEmpty) return;
    setState(() {
      _tasks.add(task.trim());
      _controller.clear();
    });
    _saveTasks();
  }

  void _toggleComplete(int index) {
    setState(() {
      _completedTasks.contains(index)
          ? _completedTasks.remove(index)
          : _completedTasks.add(index);
    });
    _saveTasks();
  }

  void _removeTask(int index) {
    setState(() {
      _tasks.removeAt(index);
      _completedTasks.remove(index);
      _completedTasks.removeWhere((i) => i >= _tasks.length);
    });
    _saveTasks();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final onBackground = theme.colorScheme.onBackground;
    final surface = theme.colorScheme.surface;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your To-Do List"),
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [theme.colorScheme.background, surface],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Gradient Input Row
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      primary.withOpacity(0.1),
                      primary.withOpacity(0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(32),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        onSubmitted: _addTask,
                        decoration: const InputDecoration(
                          hintText: "Add a task...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => _addTask(_controller.text),
                      icon: const Icon(Icons.add_circle_rounded),
                      color: primary,
                      iconSize: 32,
                    ),
                  ],
                ),
              )
                  .animate()
                  .fadeIn(duration: 500.ms)
                  .slideY(begin: 0.2, curve: Curves.easeOut),

              const SizedBox(height: 20),

              // Task List
              Expanded(
                child: _tasks.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.hourglass_empty,
                                size: 64, color: Colors.grey),
                            const SizedBox(height: 10),
                            Text(
                              "No tasks yet! Why not create some?",
                              style: TextStyle(
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                                color: onBackground.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ).animate().fadeIn().moveY(begin: 10),
                      )
                    : ListView.builder(
                        itemCount: _tasks.length,
                        itemBuilder: (context, index) {
                          final task = _tasks[index];
                          final isCompleted = _completedTasks.contains(index);

                          return Dismissible(
                            key: Key(task + index.toString()),
                            direction: DismissDirection.endToStart,
                            onDismissed: (_) => _removeTask(index),
                            background: Container(
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              padding: const EdgeInsets.only(right: 20),
                              alignment: Alignment.centerRight,
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Icon(Icons.delete,
                                  color: Colors.white, size: 28),
                            ),
                            child: GestureDetector(
                              onTap: () => _toggleComplete(index),
                              child: AnimatedContainer(
                                duration: 300.ms,
                                margin: const EdgeInsets.symmetric(vertical: 6),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: isCompleted
                                      ? primary.withOpacity(0.15)
                                      : surface.withOpacity(0.9),
                                  boxShadow: [
                                    BoxShadow(
                                      color: isCompleted
                                          ? Colors.transparent
                                          : Colors.black12,
                                      blurRadius: 6,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    AnimatedContainer(
                                      duration: 300.ms,
                                      curve: Curves.easeOut,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: primary, width: 2),
                                        color: isCompleted
                                            ? primary
                                            : Colors.transparent,
                                      ),
                                      width: 24,
                                      height: 24,
                                      child: isCompleted
                                          ? const Icon(Icons.check,
                                              size: 16, color: Colors.white)
                                          : null,
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Text(
                                        task,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: isCompleted
                                              ? onBackground.withOpacity(0.4)
                                              : onBackground,
                                          decoration: isCompleted
                                              ? TextDecoration.lineThrough
                                              : null,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ).animate().fadeIn().slideX(begin: 0.1),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
