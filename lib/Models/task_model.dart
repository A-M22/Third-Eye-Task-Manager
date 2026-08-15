import 'package:flutter/material.dart';

enum Priority
{
  
  high(color: Colors.red, title:"High"),
  medium(color:Colors.amber, title: "Medium"),
  low(color: Colors.green, title:"Low");

  const Priority({ required this.color, required this.title });

  final Color color;
  final String title;

}

enum Status
{
  pending(title:"Pending"),
  inProgress(title: "In Progress"),
  completed(title: "Completed");

  const Status({required this.title});

  final String title;

}

class Task
{
  const Task({required this.title,
    required this.description,
    required this.priority,
    required this.status,
    required this.date});

  final String title;
  final String description;
  final Priority priority;
  final Status status;
  final DateTime date;
}