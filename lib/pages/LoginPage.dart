import 'package:flutter/material.dart';
import 'package:savespot_project/pages/LandingPage.dart';
import 'package:savespot_project/pages/RegisterPage.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  bool _obscurePassword = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.brown[50],

      body: Center(
          child: SizedBox(
              width: 300,
              child: Form(
                key: _formKey,
                  child:
                  Column(
                      children: [
                        SizedBox(height: 150),
                        Text('Welcome Back!',
                          style:
                          TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),),
                        SizedBox(height: 80),
                        TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                            ),
                            validator: (value){
                              if(value==null || value.isEmpty){
                                return 'Please enter your mail';
                              }
                              final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                              if(!emailRegex.hasMatch(value)){
                                return 'Invalid email';
                              }
                              return null;
                            }
                        ),
                        TextFormField(
                          controller: _passwordController,
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if(value.length < 6){
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          }

                        ),
                        SizedBox(height: 80,),
                        ElevatedButton(
                            onPressed: () {
                              //go to homePage
                              if(_formKey.currentState!.validate()){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Landingpage())
                                );
                              }
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
                  ),
              )

          )
      ),



    );
  }
}