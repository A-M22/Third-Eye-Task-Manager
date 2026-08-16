import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Third Eye Task Manager"),
      ),
      floatingActionButton: FloatingActionButton(
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
                  description: " ",
                ),
              ),
            ),
          );
          if (newTask != null) {
            context.read<TaskCubit>().addTask(newTask);
          }
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Container(
          child: BlocBuilder<TaskCubit, TaskState>(
            builder: (context, state) {
              if (state is TaskLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is TaskError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.message,
                        style: const TextStyle(color: Colors.red),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          context.read<TaskCubit>().fetchAllTasks();
                        },
                        child: const Text("Retry"),
                      ),
                    ],
                  ),
                );
              } else if (state is TaskEmpty) {
                return const Center(child: Text("No Tasks Available"));
              } else if (state is TaskSuccess) {
                return ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: state.tasks.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        const SizedBox(height: 10),
                        TaskCard(
                          task: state.tasks[index],
                          onDelete: () {
                            context.read<TaskCubit>().deleteTask(state.tasks[index].id!);
                          },
                          onUpdate: (updatedTask) {
                            context.read<TaskCubit>().updateTask(updatedTask);
                          },
                        ),
                      ],
                    );
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}