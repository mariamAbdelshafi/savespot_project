import 'package:flutter/material.dart';
import 'package:savespot_project/pages/LandingPage.dart';
import 'package:savespot_project/pages/RegisterPage.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  bool _obscurePassword = true;
  final _emailController = TextEditingController();
  final _resetEmailController = TextEditingController();
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
                            onPressed: () async {
                              //go to homePage
                              if (_formKey.currentState!.validate()) {
                                try {
                                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim(),
                                  );

                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Landingpage())
                                  );
                                } on FirebaseAuthException catch (e) {
                                  String message = 'Login failed';
                                  if (e.code == 'user-not-found') {
                                    message = 'No user found for that email.';
                                  } else if (e.code == 'wrong-password') {
                                    message = 'Wrong password.';
                                  }
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(message)),
                                  );
                                }
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
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.brown[100],
                                      title: Text('Create a new password',
                                      style: TextStyle(
                                        color: Colors.brown
                                      ),),
                                      content:
                                          Container(
                                            width: 200,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10)
                                            ),
                                            child:
                                            Column(
                                              children: [
                                                TextFormField(
                                                  controller: _resetEmailController,
                                                  decoration: InputDecoration(
                                                    labelText: 'Enter your email',
                                                  ),
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return 'Please enter an email';
                                                }
                                                final emailRegex = RegExp(
                                                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                                if (!emailRegex.hasMatch(value)) {
                                                  return 'Invalid email';
                                                }
                                                return null;
                                              },
                                                ),
                                              ],
                                            ),
                                    ),
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () async {
                                              try{
                                                await FirebaseAuth.instance.sendPasswordResetEmail(
                                                  email: _resetEmailController.text.trim(),
                                                );
                                              }
                                              catch (e){
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(content: Text('Failed to send email')),
                                                );
                                              }
                                              Navigator.of(context).pop();
                                            },
                                            style : ElevatedButton.styleFrom(
                                              backgroundColor: Colors.brown[300],
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10)
                                              )
                                            ),
                                            child: Text('Send email',
                                            style: TextStyle(
                                              color: Colors.white
                                            ),)),
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.brown[300],
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10)
                                              )
                                            ),
                                            child: Text('Cancel',
                                            style: TextStyle(
                                              color: Colors.white
                                            ),))
                                      ],
                                    );
                                  },
    );
  },

                                  child: Text(
                                    'Forgot password?',
                                    style: TextStyle(
                                      color: Colors.brown[700],
                                      decoration: TextDecoration.underline,
                                    ),
                                  )

                        ),
                        SizedBox(height: 150),
                        Text("You don't have an account?",
                          style: TextStyle(
                            color: Colors.brown[800],
                          ),),
                        TextButton(
                            onPressed: (){
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