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

    return  GestureDetector(
      onTap: ()async {

        final result =await Navigator.push(
          context,
          MaterialPageRoute(builder:(context)=> TaskDetailsScreen(task:task)),
        );
        if(result==true)
        {
          onDelete();
        }
        else if (result!=null&& result is Task)
        {
          onUpdate(result);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: task.priority.color, width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding:EdgeInsets.all(10.0) ,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Expanded(child: Text(task.title, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: task.priority.color),)),
                    SizedBox(width: 10,),
                    Text(formattedDate, style: TextStyle(fontSize: 16.0, color: Colors.grey),),
                    SizedBox(width: 10.0,),
                    Text(task.status.title, style: TextStyle(color: Colors.blue),),
                    SizedBox(width: 10.0,),
                    Text(task.priority.title, style: TextStyle(fontSize: 14.0, color: task.priority.color),),
                    ],
                  ),
                  Text(task.description, style: TextStyle(fontSize: 16.0),),
                ],
              ),
      )
    );
  }
}