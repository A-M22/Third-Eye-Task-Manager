import 'package:flutter/material.dart';
import 'package:third_eye_task_manager/PL/card.dart';
import 'package:third_eye_task_manager/Models/task_model.dart';

class home_screen extends StatefulWidget {
  const home_screen({super.key});

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {

  List<Task> tasks=[
      Task(
        priority: Priority.high,
        status: Status.pending,
        title: "Clean the car",
        description: "I have to clean the car before I go to china and germany and italy",
        date: DateTime(2026, 3, 10)
      ),
      Task(
        priority: Priority.medium,
        status: Status.inProgress,
        title: "Buy groceries",
        description: "I need to buy milk, bread, and eggs for the week.",
        date: DateTime(2026, 3, 15),
      ),
      Task(
        priority: Priority.low,
        status: Status.completed,
        title: "Read a book",
        description: "I want to finish reading '1984' by George Orwell.",
        date: DateTime(2026, 3, 20),
      ),
    ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Third Eye Task Manager"),
      ),
      body:
      SafeArea(child:
      Container(
        
        child:tasks.isEmpty ? Center(child: Text("No tasks available")) : ListView.builder(
          padding:const EdgeInsets.all(10.0),
          
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                SizedBox(height: 10.0,),
                TaskCard(task: tasks[index]),
              ],
            );
          },
        ), 
      )
      )
    );
  }
}