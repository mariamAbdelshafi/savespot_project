import 'package:flutter/material.dart';
import 'package:savespot_project/pages/HomePage.dart';
import 'package:savespot_project/pages/RegisterPage.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  bool _obscurePassword = true;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.brown[50],

      body: Center(
          child: SizedBox(
              width: 300,
              child: Column(
                  children: [
                    SizedBox(height: 150),
                    Text('Welcome Back!',
                      style:
                      TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),),
                    SizedBox(height: 80),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                    ),
                    TextField(
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword? Icons.visibility_off : Icons.visibility,
                            color: Colors.brown[800],
                          ),
                          onPressed: (){
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            }
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 80,),
                    ElevatedButton(
                        onPressed: () {
                          //go to homePage
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomePage())
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown,
                          minimumSize: Size(200, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text('LOGIN',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        )
                    ),
                    TextButton(
                        onPressed: (){
                          //reset password
                        },
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(
                            color: Colors.brown[700],
                            decoration: TextDecoration.underline,
                          ),
                        )),
                    SizedBox(height: 150),
                    Text("You don't have an account?",
                      style: TextStyle(
                        color: Colors.brown[800],
                      ),),
                    TextButton(
                        onPressed: (){
                          //register page
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => RegisterPage())
                          );
                        },
                        child: Text('Sign up',
                          style: TextStyle(
                            color: Colors.brown[500],
                            decoration: TextDecoration.underline,
                          ),)
                    )
                  ]
              )
          )
      ),



    );
  }
}