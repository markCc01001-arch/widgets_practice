// main.dart
import 'package:flutter/material.dart';
import 'widgets/task_card.dart';

void main() => runApp(const TaskApp());

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Widget Fundamentals Demo',
      theme: ThemeData(useMaterial3: true),
      home: const TaskListPage(),
    );
  }
}

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  final List<Map<String, dynamic>> _demoTasks = [
    {
      'title': 'Write unit tests',
      'description': 'Cover TaskCard widget and interactive behavior.',
      'priority': 'Medium',
      'date': '23/09/2025',
      'name': 'Mark',
      'isImportant': false, // 👈 added
    },
    {
      'title': 'Refactor auth',
      'description': 'Move logic into a reusable AuthService and clean up UI.',
      'priority': 'Low',
      'date': '26/09/2025',
      'name': 'Pierre',
      'isImportant': false,
    },
    {
      'title': 'Design review',
      'description': 'Prepare slides for Friday review with product.',
      'priority': 'High',
      'date': '02/10/2025',
      'name': 'Arjay',
      'isImportant': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tasks')),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: _demoTasks.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, i) {
          final t = _demoTasks[i];
          return TaskCard(
            title: t['title']!,
            description: t['description']!,
            priority: t['priority']!,
            assignee: t['name']!,
            isImportant: t['isImportant'],
            onToggleImportant: () {
              setState(() {
                _demoTasks[i]['isImportant'] = !_demoTasks[i]['isImportant'];
              });
            },
          );
        },
      ),
    );
  }
}

void _openAddModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (_) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Add Task', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              const TextField(decoration: InputDecoration(labelText: 'Title')),
              const SizedBox(height: 8),
              const TextField(
                maxLines: 2,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Create (UI only)'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      );
    },
  );
}
