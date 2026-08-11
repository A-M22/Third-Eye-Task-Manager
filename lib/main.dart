import 'package:flutter/material.dart';
import 'package:third_eye_task_manager/PL/login_screen.dart';

void main() {
  runApp(const MainApp());
}


class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Third Eye Task Manager',
      
      home: LoginScreen(),
    );
  }
}