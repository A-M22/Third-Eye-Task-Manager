import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:third_eye_task_manager/BLL/task_cubit.dart';
import 'package:third_eye_task_manager/PL/home.dart';
import 'package:third_eye_task_manager/PL/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
WidgetsFlutterBinding.ensureInitialized();

final prefs=await SharedPreferences.getInstance();
final bool isLoggedIn=prefs.getBool('isLoggedIn') ?? false;

runApp(MainApp(isLoggedIn: isLoggedIn));


}


class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.isLoggedIn});

  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create:(context)=>TaskCubit()..fetchAllTasks(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Third Eye Task Manager',
        initialRoute: isLoggedIn ? '/home' : '/login',
        routes: {
          '/login':(context)=>const LoginScreen(),
          '/home':(context)=>const home_screen(),
        },
      ),
    );
  }
}