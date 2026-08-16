import 'package:flutter/material.dart';
import 'package:third_eye_task_manager/Models/task_model.dart';

class Add_Task extends StatefulWidget {
  const Add_Task({super.key,required this.add, required this.task});
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
  void initState()
  {
    super.initState();
    _titleController.text = widget.task.title;
    _descController.text = widget.task.description;
    _priority=widget.task.priority;
    _status=widget.task.status;
    _date=widget.task.date;
  }
  @override
  Widget build(BuildContext context) {
    
    final bool add=widget.add;

    return Scaffold(
    appBar: AppBar(
      title:Text(add?"Add a task":"Edit a task"),),
    body:

      Column(
        children: [
          if (_errorMessage.isNotEmpty)
            Text(
              _errorMessage,
              style: const TextStyle(color: Colors.red),
            ),
          Row(
            children: [
              Text("Title: "),
              Expanded(
                child: TextField(
                  controller: _titleController,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text("Description: "),
              Expanded(
                child: TextField(
                  controller: _descController,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text("Date: "),
              TextButton.icon(
                icon: const Icon(Icons.calendar_today),
                // Read from your local _date variable
                label: Text("${_date.day}/${_date.month}/${_date.year}"),
                onPressed: () async {
                  // 1. Pop up the built-in calendar
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _date, // Start on current task date
                    firstDate: DateTime(2000),  // Earliest allowed date
                    lastDate: DateTime(2100),   // Latest allowed date
                  );

                  // 2. If they picked a date (didn't hit cancel), update the screen!
                  if (pickedDate != null) {
                    setState(() {
                      _date = pickedDate;
                    });
                  }
                },
              ),
            ],
          ),
          Row(
            children: [
              Text("Priority: "),
              DropdownButton<Priority>(
                value: _priority,
                items: Priority.values.map((Priority priorityEnum)
                {
                  return DropdownMenuItem<Priority>(
                    value:priorityEnum,
                    child:Text(Priority.values[priorityEnum.index].title, style: TextStyle(color: Priority.values[priorityEnum.index].color),),
                  );
                }
                ).toList(),
                onChanged: (value) {
                  if(value!=null)
                  {
                    setState(() {
                      _priority=value;
                    });
                  }
                },
              ),
            ],
          ),
          Row(
            children:[
              Text("Status: "),
              DropdownButton<Status>(
                value: _status,
                items: Status.values.map(
                  (Status statusEnum)
                  {
                    return DropdownMenuItem<Status>(
                      value:statusEnum,
                      child: Text(Status.values[statusEnum.index].title, style: const TextStyle(color: Colors.blue),),
                    );
                  }
                ).toList(),
                onChanged: (value) {
                  if(value!=null)
                  {
                    setState(() {
                      _status=value;
                    });
                  }
                }
              ),
            ]
          ),
          ElevatedButton(child:Text(add?"Add Task":"Edit Task"),
          onPressed:(){
            final Task newTask=Task(
              id: widget.task.id,
              title: _titleController.text,
              description: _descController.text,
              priority: _priority,
              status: _status,
              date: _date
            );
            if(_titleController.text.isEmpty)
            {
              setState(() {
                _errorMessage="No allowed empty fields!";
              });
              return;
            }
            else{
              Navigator.pop(context,newTask);
            }
          }
          ),
        ],
      )
    );
  }
}