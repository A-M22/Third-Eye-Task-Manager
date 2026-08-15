import 'package:flutter/material.dart';
import 'package:third_eye_task_manager/PL/TaskDetailsScreen.dart';
import 'package:third_eye_task_manager/PL/card.dart';
import 'package:third_eye_task_manager/PL/home.dart';
import 'package:third_eye_task_manager/PL/login_screen.dart';

void main() {
  runApp(const MainApp());
}


class MainApp extends StatelessWidget {
  const MainApp({super.key});

  

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Third Eye Task Manager',

      

      initialRoute: '/login',

      routes: {
        '/login':(context)=>const LoginScreen(),
        '/home':(context)=>const home_screen(),
      },
    );
  }
}