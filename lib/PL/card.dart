// lib/PL/card.dart
import 'package:flutter/material.dart';
import 'package:third_eye_task_manager/Models/task_model.dart';
import 'package:third_eye_task_manager/PL/TaskDetailsScreen.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task, required this.onDelete, required this.onUpdate});
  final Task task;
  final VoidCallback onDelete;
  final Function(Task) onUpdate;

  @override
  Widget build(BuildContext context) {
    String formattedDate = "${task.date.day}/${task.date.month}/${task.date.year}";

    return GestureDetector(
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TaskDetailsScreen(task: task)),
        );
        if (result == true) {
          onDelete();
        } else if (result != null && result is Task) {
          onUpdate(result);
        }
      },
      child: Card(
        elevation: 2,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            border: Border(
              left: BorderSide(
                color: task.priority.color,
                width: 6.0,
              ),
            ),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      task.title,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: task.priority.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Text(
                      task.priority.title,
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: task.priority.color,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                task.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14.0, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: 14.0, color: Colors.grey.shade500),
                      const SizedBox(width: 6.0),
                      Text(
                        formattedDate,
                        style: TextStyle(fontSize: 13.0, color: Colors.grey.shade600, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      task.status.title,
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}