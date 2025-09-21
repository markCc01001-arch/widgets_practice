import 'package:flutter/material.dart';
import 'icon_label.dart';

/// ---------------------------
/// Widget: TaskCard (Stateless)
/// ---------------------------
/// You can extract this to its own file: widgets/task_card.dart
class TaskCard extends StatelessWidget {
  final String title;
  final String description;
  final String priority;
  final String dateLabel; // <-- new
  final String assignee;
  final bool isImportant;
  final VoidCallback? onToggleImportant; // 👈 new

  const TaskCard({
    super.key,
    required this.title,
    required this.description,
    required this.priority,
    this.dateLabel = 'Today', // <-- default fallback
    required this.assignee,
    this.isImportant = false,
    this.onToggleImportant, // 👈 optional callback
  });
  Color _priorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: const Color.fromARGB(255, 255, 237, 155),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row: Priority badge + Important star
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _PriorityBadge(priority: priority),
                IconButton(
                  icon: Icon(
                    isImportant ? Icons.star : Icons.star_border,
                    color: isImportant
                        ? const Color.fromARGB(255, 255, 166, 0)
                        : Colors.grey,
                  ),
                  onPressed: onToggleImportant, // 👈 call parent
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Title
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 6),

            // Assignee + Due Date
            Row(
              children: [
                IconLabel(
                  icon: Icons.person,
                  label: assignee,
                  iconColor: Colors.blue,
                ),
                const SizedBox(width: 16),
                IconLabel(
                  icon: Icons.event,
                  label: dateLabel,
                  iconColor: _priorityColor(priority),
                ),
              ],
            ),

            const SizedBox(height: 6),

            // Description
            Text(description, maxLines: 2, overflow: TextOverflow.ellipsis),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

/// Small private sub-widget (extractable)
class _PriorityBadge extends StatelessWidget {
  final String priority;
  const _PriorityBadge({super.key, required this.priority});

  Color get _color {
    switch (priority.toLowerCase()) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: _color.withOpacity(0.15),
      label: Text(
        priority,
        style: TextStyle(color: _color, fontWeight: FontWeight.bold),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      side: BorderSide.none, // 👈 explicitly removes the outline
    );
  }
}
