// lib/PL/login_screen.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  String _email = '';
  String _password = '';
  bool _hidden = true;
  String errorMessage = '';
  final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.task_alt,
                  size: 80,
                  color: Colors.blueAccent,
                ),
                const SizedBox(height: 16),
                const Text(
                  "Third Eye",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                const Text(
                  "Task Manager",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 40),
                if (errorMessage.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(bottom: 20.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: Colors.red.shade200),
                    ),
                    child: Text(
                      errorMessage,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email",
                    prefixIcon: const Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                  ),
                  onChanged: (value) => setState(() {
                    _email = value;
                  }),
                ),
                const SizedBox(height: 20.0),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      onPressed: () => {
                        setState(() {
                          _hidden = !_hidden;
                        }),
                      },
                      icon: Icon(_hidden ? Icons.visibility_off : Icons.visibility),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                  ),
                  obscureText: _hidden,
                  onChanged: (value) => setState(() {
                    _password = value;
                  }),
                ),
                const SizedBox(height: 32.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 2,
                  ),
                  onPressed: () async {
                    if (_email.isEmpty || _password.isEmpty) {
                      setState(() {
                        errorMessage = "Fields Can't be empty!";
                      });
                    } else if (!emailRegex.hasMatch(_email)) {
                      setState(() {
                        errorMessage = "email format is not correct";
                      });
                    } else {
                      setState(() {
                        errorMessage = "";
                      });
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('isLoggedIn', true);
                      Navigator.pushReplacementNamed(context, '/home');
                    }
                  },
                  child: const Text(
                    'Log in',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}