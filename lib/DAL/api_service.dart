import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:third_eye_task_manager/Models/task_model.dart';

class ApiService
{
  static const String baseUrl = 'https://6a80cb58ec7a640e63abf648.mockapi.io/Tasks';

  static Future<List<Task>> fetchTasks() async
  {
    final response =await http.get(Uri.parse(baseUrl));

    if(response.statusCode==200)
    {
      List<dynamic> jsonList=json.decode(response.body);
      return jsonList.map((json) => Task.fromJson(json)).toList();

    }
    else
    {
      throw Exception('Failed to load tasks');
    }

  }

  static Future<Task> addTask(Task task) async
  {
    final response =await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(task.toJson()),
    );
    if (response.statusCode==201)
    {
      return Task.fromJson(json.decode(response.body));
    }
    else
    {
      throw Exception('Failed to add task');
    }
  }

  static Future<Task> updateTask(Task task) async
  {
    final response = await http.put(
      Uri.parse('$baseUrl/${task.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(task.toJson())
    );
    if(response.statusCode==200)
    {
      return Task.fromJson(json.decode(response.body));
    }
    else{
      throw Exception('Faild to update Task');
    }
  }

  static Future<void> deleteTask(String id) async
  {
    final response= await http.delete(
      Uri.parse('$baseUrl/$id')
    );
    if(response.statusCode!=200)
    {
      throw Exception("Faild to delete Task");
    }
  }

}