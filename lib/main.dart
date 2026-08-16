import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:third_eye_task_manager/BLL/task_cubit.dart';
import 'package:third_eye_task_manager/PL/home.dart';
import 'package:third_eye_task_manager/PL/login_screen.dart';

void main() {
  runApp(const MainApp());
}


class MainApp extends StatelessWidget {
  const MainApp({super.key});

  

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create:(context)=>TaskCubit()..fetchAllTasks(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Third Eye Task Manager',
        initialRoute: '/login',
        routes: {
          '/login':(constext)=>const LoginScreen(),
          '/home':(context)=>const home_screen(),
        },
      ),
    );
  }
}