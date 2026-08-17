// lib/PL/TaskDetailsScreen.dart
import 'package:flutter/material.dart';
import 'package:third_eye_task_manager/Models/task_model.dart';
import 'package:third_eye_task_manager/PL/addTask.dart';

class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen({super.key, required this.task});

  final Task task;

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  late Task currentTask;

  @override
  void initState() {
    super.initState();
    currentTask = widget.task;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text("Task Details", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context, currentTask),
            icon: const Icon(Icons.check),
            tooltip: "Save & Close",
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentTask.title,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 16),
                    const Text(
                      "Description",
                      style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      currentTask.description.isEmpty ? "No description provided." : currentTask.description,
                      style: const TextStyle(fontSize: 16, height: 1.5),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Due Date",
                                style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Icon(Icons.calendar_month, size: 18, color: Colors.grey.shade700),
                                  const SizedBox(width: 6),
                                  Text(
                                    "${currentTask.date.day}/${currentTask.date.month}/${currentTask.date.year}",
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Priority",
                                style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Icon(Icons.flag, size: 18, color: currentTask.priority.color),
                                  const SizedBox(width: 6),
                                  Text(
                                    currentTask.priority.title,
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: currentTask.priority.color),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "Status",
                      style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12.0),
                        color: Colors.white,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<Status>(
                          isExpanded: true,
                          value: currentTask.status,
                          items: Status.values.map((Status statusEnum) {
                            return DropdownMenuItem<Status>(
                              value: statusEnum,
                              child: Text(
                                statusEnum.title,
                                style: const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
                              ),
                            );
                          }).toList(),
                          onChanged: (Status? newStatus) {
                            if (newStatus != null) {
                              setState(() {
                                currentTask = Task(
                                  id: currentTask.id,
                                  title: currentTask.title,
                                  description: currentTask.description,
                                  priority: currentTask.priority,
                                  date: currentTask.date,
                                  status: newStatus,
                                );
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                      foregroundColor: Colors.red,
                      side: BorderSide(color: Colors.red.shade200),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                            title: const Text("Delete Task", style: TextStyle(fontWeight: FontWeight.bold)),
                            content: const Text("Are you sure you want to delete this task? This action cannot be undone."),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Cancel"),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context, true);
                                },
                                child: const Text("Delete"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.delete_outline),
                    label: const Text("Delete", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                      elevation: 2,
                    ),
                    onPressed: () async {
                      final updatedTask = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Add_Task(add: false, task: currentTask)),
                      );
                      if (updatedTask != null) {
                        setState(() {
                          currentTask = updatedTask;
                        });
                      }
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text("Edit", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}