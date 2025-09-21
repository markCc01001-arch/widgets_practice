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
  String _selectedFilter = "All";
  final List<Map<String, dynamic>> _demoTasks = [
    {
      'title': 'Feed the dog',
      'description':
          'Give the dog its meal (food and clean water) at the scheduled time to keep it healthy and happy.',
      'priority': 'High',
      'date': '23/09/2025',
      'name': 'Joshua',
      'isImportant': false, //
    },
    {
      'title': 'Do homework',
      'description':
          'Complete the assigned exercises or readings for each subject before the deadline to stay prepared for class.',
      'priority': 'Low',
      'date': '26/09/2025',
      'name': 'Pierre',
      'isImportant': false,
    },
    {
      'title': 'Clean my room',
      'description':
          'Organize books and clothes, sweep or vacuum the floor, and make the bed to keep the room tidy',
      'priority': 'Medium',
      'date': '02/10/2025',
      'name': 'Mark',
      'isImportant': true,
    },

    {
      'title': 'Study for exams',
      'description':
          'Review notes, practice sample questions, and summarize key topics to prepare for upcoming tests.',
      'priority': 'High',
      'date': '23/9/2025',
      'name': 'Joshua',
      'isImportant': true,
    },
    {
      'title': 'Wash the dishes',
      'description':
          'Clean the used plates, glasses, and utensils, then dry and return them to their proper places.',
      'priority': 'Medium',
      'date': '02/9/2025',
      'name': 'Arjay',
      'isImportant': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredTasks = _selectedFilter == "All"
        ? _demoTasks
        : _demoTasks.where((t) => t['priority'] == _selectedFilter).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 236, 200, 39),
        title: const Text(
          'Tasks',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedFilter,
              hint: const Text("All", style: TextStyle(color: Colors.white)),
              items: const [
                DropdownMenuItem(
                  value: "All",
                  child: Text(
                    "All",
                    style: TextStyle(color: Colors.white),
                  ), // 👈
                ),
                DropdownMenuItem(
                  value: "Low",
                  child: Text("Low", style: TextStyle(color: Colors.white)),
                ),
                DropdownMenuItem(
                  value: "Medium",
                  child: Text("Medium", style: TextStyle(color: Colors.white)),
                ),
                DropdownMenuItem(
                  value: "High",
                  child: Text("High", style: TextStyle(color: Colors.white)),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedFilter = value;
                  });
                }
              },
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Color.fromARGB(255, 236, 205, 30),
              ),
              dropdownColor: const Color.fromARGB(
                255,
                255,
                210,
                85,
              ), // 👈 dropdown bg
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
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
            dateLabel: t['date']!,
            isImportant: t['isImportant'],
            onToggleImportant: () {
              setState(() {
                _demoTasks[i]['isImportant'] = !_demoTasks[i]['isImportant'];
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddModal(context),
        child: const Icon(Icons.add),
      ),
    );
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
                const TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                ),
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
                        onPressed: () {
                          // Show snackbar
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("(UI-only) Task created"),
                              duration: Duration(seconds: 2),
                            ),
                          );

                          // Close modal
                          Navigator.pop(context);
                        },
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
}
