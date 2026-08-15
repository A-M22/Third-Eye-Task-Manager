import 'package:flutter/material.dart';
import 'package:third_eye_task_manager/Models/task_model.dart'; 
import 'package:third_eye_task_manager/PL/addTask.dart';

class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen({super.key,required this.task});


  final Task task;


  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  
  late Task currentTask;

  @override
  void initState()
  {
    super.initState();
    currentTask=widget.task;
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Task Details"),
        actions:[
          IconButton(
            onPressed: ()=> Navigator.pop(context, currentTask),
            icon: const Icon(Icons.check)
          ),
        ]
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              currentTask.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Description: ${currentTask.description}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              "Priority: ${currentTask.priority.title}",
              style: TextStyle(fontSize: 16, color: currentTask.priority.color),
            ),
            SizedBox(height: 8),
            Row(
              children:[
                Text("Status:", style: TextStyle(fontSize: 16),),
                SizedBox(width: 8,),
                DropdownButton<Status>(
                  value:currentTask.status,
                  items:Status.values.map((Status statusEnum)
                  {
                    return DropdownMenuItem<Status>(
                      value:statusEnum,
                      child: Text(statusEnum.title,style: const TextStyle(color: Colors.blue)),
                    );
                  }
                  ).toList(),
                  onChanged: (Status? newStatus){
                    if(newStatus !=null){
                      setState(() {
                        currentTask=Task(
                          title: currentTask.title,
                          description:currentTask.description,
                          priority:currentTask.priority,
                          date: currentTask.date,
                          status: newStatus
                        );
                      });
                    }
                  },
                )
              ]
            ),
            SizedBox(height: 8),
            Text(
              "Due Date: ${currentTask.date.day}/${currentTask.date.month}/${currentTask.date.year}",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final Task updatedTask=await
                    Navigator.push(context,MaterialPageRoute(builder:(context)=>Add_Task(add:false,task:currentTask)));
                    if(updatedTask!=null)
                    {
                      setState(() {
                        currentTask=updatedTask;
                      });
                    }
                  },
                  child: Text("Edit Task"),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => {
                    showDialog(context: context, builder: (context){
                      return AlertDialog(
                        title: Text("Delete Task"),
                        content: const Text("Are you sure you want to delete this task?"),
                        actions:[
                          TextButton(
                            onPressed: () => Navigator.pop(context), 
                            child: Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: (){Navigator.pop(context);Navigator.pop(context,true);},
                            child:Text("Delete", style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ]
                      );
                    })
                  },
                  child: Text("Delete Task"),

                ),
                
              ],
            ),
          ],
        ),
      ),
    );
  }
}