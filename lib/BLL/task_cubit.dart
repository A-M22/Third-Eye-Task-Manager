import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:third_eye_task_manager/Models/task_model.dart';
import 'package:third_eye_task_manager/DAL/api_service.dart';

abstract class TaskState{}

class TaskLoading extends TaskState{}

class TaskEmpty extends TaskState{}

class TaskError extends TaskState{
  final String message;
  TaskError(this.message);
}

class TaskSuccess extends TaskState{
  final List<Task> tasks;
  TaskSuccess(this.tasks);
}

class TaskCubit extends Cubit<TaskState>{
  TaskCubit(): super(TaskLoading());

  Future<void> fetchAllTasks() async{
    emit(TaskLoading());

    try{
      final tasks=await ApiService.fetchTasks();
      if(tasks.isEmpty)
      {
        emit(TaskEmpty());
      }
      else
      {
        emit(TaskSuccess(tasks));
      }
      }
      catch(e)
      {
        emit(TaskError(e.toString()));
      }

  }

  // POST: Add a new task
  Future<void> addTask(Task task) async {
    emit(TaskLoading()); // Show spinner
    try {
      await ApiService.addTask(task); // Send to MockAPI
      fetchAllTasks(); // Refresh the list to show the new task!
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  // PUT: Update a task
  Future<void> updateTask(Task task) async {
    emit(TaskLoading()); // Show spinner
    try {
      await ApiService.updateTask(task); // Send to MockAPI
      fetchAllTasks(); // Refresh the list
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  // DELETE: Remove a task
  Future<void> deleteTask(String id) async {
    emit(TaskLoading()); // Show spinner
    try {
      await ApiService.deleteTask(id); // Send to MockAPI
      fetchAllTasks(); // Refresh the list
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }
}