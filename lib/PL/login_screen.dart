import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {

  String _email='';
  String _password='';
  bool _hidden=true;
  String errorMessage='';
  final emailRegex=RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  bool isloggedin=true;

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
          child: Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Third Eye",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 40,),
                Text(
                  '$errorMessage',
                  style:TextStyle(color:Colors.red,fontWeight: FontWeight.bold),
                  ),
                SizedBox(height: 20.0,),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    label: Text("Email"),    
                  ),
                  onChanged: (value) => setState(() {
                    _email=value;
                  }),
                  ),
                  SizedBox(height: 20.0,),                 
                  TextField(
                    decoration: InputDecoration(
                      label: Text('Password'), 
                      suffixIcon: IconButton(
                      onPressed: ()=>{
                        setState((){
                        _hidden=!_hidden;}
                        ),
                        }, 
                      icon: Icon(_hidden ? Icons.visibility_off : Icons.visibility),)                     
                    ),
                    obscureText: _hidden,
                    onChanged: (value) => setState((){_password=value;}),
                  ),
            
                  SizedBox(height: 20.0,),
                  ElevatedButton(onPressed: ()
                  {

                    isloggedin?  Navigator.pushReplacementNamed(context, '/home'):context;

                    if(_email.isEmpty || _password.isEmpty)
                    {
                      setState(() {
                        errorMessage="Fields Can't be empty!";
                      });
                    }
                    else if (!emailRegex.hasMatch(_email))
                    {
                      setState(() {
                        errorMessage="email format is not correct";
                      });
                    }
                    else
                    {
                      setState(() {
                        errorMessage="";
                      });
                      //go to homepage after success//
                      Navigator.pushReplacementNamed(context, '/home');
                    }
                  }, 
                  child:Text('Log in'), 
                  ),

              ],
            ),
          ),
        ),
      );
    
  }
}