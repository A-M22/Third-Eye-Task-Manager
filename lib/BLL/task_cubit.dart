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

  List<Task> _allTasks=[];
  String _currentQuery='';
  Status? _currentStatus;
  Priority? _currentPriority;

  Future<void> fetchAllTasks() async{
    emit(TaskLoading());

    try{
      final tasks=await ApiService.fetchTasks();
      _allTasks=tasks;
      _applyFilters();
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

  void updateFilters({
    String? query,
    Status? status,
    Priority? priority,
    bool clearStatus=false,
    bool clearPriority=false,
  }){
    if(query!=null)
    {
      _currentQuery=query;
    }
    if(status!=null)
    {
      _currentStatus=status;
    }
    if(priority!=null)
    {
      _currentPriority=priority;
    }
    if(clearStatus)
    {
      _currentStatus=null;
    }
    if(clearPriority)
    {
      _currentPriority=null;
    }

    _applyFilters();
  }

  void _applyFilters()
  {
    var filteredTasks=_allTasks;
    if(_currentQuery.isNotEmpty)
    {
      filteredTasks=filteredTasks.where((task)=>
      task.title.toLowerCase().contains(_currentQuery.toLowerCase())).toList();
    }

    if(_currentStatus!=null)
    {
      filteredTasks=filteredTasks.where((task)=>task.status==_currentStatus).toList();
    }

    if(_currentPriority!=null)
    {
      filteredTasks=filteredTasks.where((task)=>task.priority==_currentPriority).toList();
    }

    if (_allTasks.isEmpty) {
      emit(TaskEmpty());
    } else if (filteredTasks.isEmpty) {
      emit(TaskEmpty());
    } else {
      emit(TaskSuccess(filteredTasks));
    }

  }

  void searchTasks(String qurery)
  {
    if(qurery.isEmpty)
    {
      if(_allTasks.isEmpty)
      {
        emit(TaskEmpty());
      }
      else
      {
        emit(TaskSuccess(_allTasks));
      }
      return;
    }
    final filteredTasks=_allTasks.where((task){
      return task.title.toLowerCase().contains(qurery.toLowerCase());
    }).toList();

    if (filteredTasks.isEmpty)
    {
      emit(TaskEmpty());
    }
    else
    {
      emit(TaskSuccess(filteredTasks));
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