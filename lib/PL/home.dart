// lib/PL/home.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:third_eye_task_manager/PL/addTask.dart';
import 'package:third_eye_task_manager/PL/card.dart';
import 'package:third_eye_task_manager/Models/task_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:third_eye_task_manager/BLL/task_cubit.dart';

class home_screen extends StatefulWidget {
  const home_screen({super.key});

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  Status? _selectedStatus;
  Priority? _selectedPriority;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          "Third Eye Task Manager",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool('isLoggedIn', false);
              Navigator.pushReplacementNamed(context, '/login');
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        onPressed: () async {
          final newTask = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Add_Task(
                add: true,
                task: Task(
                  date: DateTime.now(),
                  title: "",
                  priority: Priority.low,
                  status: Status.pending,
                  description: "",
                ),
              ),
            ),
          );
          if (newTask != null) {
            context.read<TaskCubit>().addTask(newTask);
          }
        },
        icon: const Icon(Icons.add),
        label: const Text("New Task"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: "Search tasks...",
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
                onChanged: (value) {
                  context.read<TaskCubit>().updateFilters(query: value);
                },
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<Status?>(
                          isExpanded: true,
                          value: _selectedStatus,
                          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                          hint: const Text("All Statuses"),
                          items: [
                            const DropdownMenuItem(value: null, child: Text("All Statuses")),
                            ...Status.values.map((s) => DropdownMenuItem(
                                  value: s,
                                  child: Text(s.title, style: const TextStyle(color: Colors.blue)),
                                )),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedStatus = value;
                            });
                            context.read<TaskCubit>().updateFilters(
                                  status: value,
                                  clearStatus: value == null,
                                );
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<Priority?>(
                          isExpanded: true,
                          value: _selectedPriority,
                          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                          hint: const Text("All Priorities"),
                          items: [
                            const DropdownMenuItem(value: null, child: Text("All Priorities")),
                            ...Priority.values.map((p) => DropdownMenuItem(
                                  value: p,
                                  child: Text(p.title, style: TextStyle(color: p.color, fontWeight: FontWeight.w600)),
                                )),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedPriority = value;
                            });
                            context.read<TaskCubit>().updateFilters(
                                  priority: value,
                                  clearPriority: value == null,
                                );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<TaskCubit, TaskState>(
                  builder: (context, state) {
                    if (state is TaskLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is TaskError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.error_outline, size: 48, color: Colors.red),
                            const SizedBox(height: 16),
                            Text(
                              state.message,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.red, fontSize: 16),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                              ),
                              onPressed: () {
                                context.read<TaskCubit>().fetchAllTasks();
                              },
                              icon: const Icon(Icons.refresh),
                              label: const Text("Retry"),
                            ),
                          ],
                        ),
                      );
                    } else if (state is TaskEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.inbox_outlined, size: 64, color: Colors.grey.shade400),
                            const SizedBox(height: 16),
                            Text(
                              "No Tasks Available",
                              style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      );
                    } else if (state is TaskSuccess) {
                      return ListView.builder(
                        padding: const EdgeInsets.only(bottom: 80.0),
                        itemCount: state.tasks.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: TaskCard(
                              task: state.tasks[index],
                              onDelete: () {
                                context.read<TaskCubit>().deleteTask(state.tasks[index].id!);
                              },
                              onUpdate: (updatedTask) {
                                context.read<TaskCubit>().updateTask(updatedTask);
                              },
                            ),
                          );
                        },
                      );
                    }
                    return const SizedBox.shrink();
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