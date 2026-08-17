// lib/PL/addTask.dart
import 'package:flutter/material.dart';
import 'package:third_eye_task_manager/Models/task_model.dart';

class Add_Task extends StatefulWidget {
  const Add_Task({super.key, required this.add, required this.task});
  final bool add;
  final Task task;
  @override
  State<Add_Task> createState() => _Add_TaskState();
}

class _Add_TaskState extends State<Add_Task> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  late Priority _priority;
  late Status _status;
  late DateTime _date;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.task.title;
    _descController.text = widget.task.description;
    _priority = widget.task.priority;
    _status = widget.task.status;
    _date = widget.task.date;
  }

  @override
  Widget build(BuildContext context) {
    final bool add = widget.add;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          add ? "Add a Task" : "Edit Task",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_errorMessage.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(bottom: 20.0),
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                prefixIcon: const Icon(Icons.title),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _descController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: "Description",
                alignLabelWithHint: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              borderRadius: BorderRadius.circular(12.0),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: _date,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  setState(() {
                    _date = pickedDate;
                  });
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Date: ${_date.day}/${_date.month}/${_date.year}",
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    const Icon(Icons.calendar_today, color: Colors.blueAccent),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<Priority>(
                    decoration: InputDecoration(
                      labelText: "Priority",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                    ),
                    value: _priority,
                    items: Priority.values.map((Priority priorityEnum) {
                      return DropdownMenuItem<Priority>(
                        value: priorityEnum,
                        child: Text(
                          Priority.values[priorityEnum.index].title,
                          style: TextStyle(color: Priority.values[priorityEnum.index].color, fontWeight: FontWeight.bold),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _priority = value;
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<Status>(
                    decoration: InputDecoration(
                      labelText: "Status",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                    ),
                    value: _status,
                    items: Status.values.map((Status statusEnum) {
                      return DropdownMenuItem<Status>(
                        value: statusEnum,
                        child: Text(
                          Status.values[statusEnum.index].title,
                          style: const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _status = value;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                elevation: 2,
              ),
              onPressed: () {
                final Task newTask = Task(
                  id: widget.task.id,
                  title: _titleController.text,
                  description: _descController.text,
                  priority: _priority,
                  status: _status,
                  date: _date,
                );
                if (_titleController.text.isEmpty) {
                  setState(() {
                    _errorMessage = "No allowed empty fields!";
                  });
                  return;
                } else {
                  Navigator.pop(context, newTask);
                }
              },
              child: Text(
                add ? "Save Task" : "Update Task",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}