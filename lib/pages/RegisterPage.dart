import 'package:flutter/material.dart';
import 'package:savespot_project/pages/LandingPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class RegisterPage extends StatefulWidget{
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>{
  bool _obscurePassword1 = true;
  bool _obscurePassword2 = true;
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _phonenumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.brown[50],
      body: Center(
          child:
          SizedBox(
            width: 300,
            child: Form(
              key: _formKey,
                child:
                Column(
                  children: [
                    SizedBox(height: 100,),
                    Text('Get started!',
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.brown[800],
                        fontWeight: FontWeight.bold,
                      ),),
                    SizedBox(height: 80),
                    SizedBox(
                      width: 350,
                      child:
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.brown[100],
                            borderRadius: BorderRadius.circular(10)),
                        child:
                        TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: 'Name',
                              contentPadding: EdgeInsets.only(left: 10),
                              border: InputBorder.none,
                            ),
                            validator: (value){
                              if(value==null || value.isEmpty){
                                return 'Please enter a name';
                              }
                              if (RegExp(r'[0-9]').hasMatch(value)) {
                                return 'Name must not contain numbers';
                              }
                              return null;
                            }
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    SizedBox(
                      width: 350,
                      child:
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.brown[100],
                            borderRadius: BorderRadius.circular(10)),
                        child:
                        TextFormField(
                            controller: _surnameController,
                            decoration: InputDecoration(
                              labelText: 'Surname',
                              contentPadding: EdgeInsets.only(left: 10),
                              border: InputBorder.none,
                            ),
                            validator: (value){
                              if(value==null || value.isEmpty){
                                return 'Please enter a surname';
                              }
                              if (RegExp(r'[0-9]').hasMatch(value)) {
                                return 'Surname must not contain numbers';
                              }
                              return null;
                            }
                        ),
                      ),
                    ),

                    SizedBox(height: 15,),
                    SizedBox(
                      width: 350,
                      child:
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.brown[100],
                            borderRadius: BorderRadius.circular(10)),
                        child:
                        TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              contentPadding: EdgeInsets.only(left: 10),
                              border: InputBorder.none,
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
                      ),
                    ),
                    SizedBox(height: 15,),
                    SizedBox(
                      width: 350,
                      child:
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.brown[100],
                            borderRadius: BorderRadius.circular(10)),
                        child:
                        TextFormField(
                          controller: _phonenumberController,
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            contentPadding: EdgeInsets.only(left: 10),
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a phone number';
                            }
                            final phoneRegex = RegExp(r'^\+?[0-9]{8,15}$');
                            if(!phoneRegex.hasMatch(value)){
                              return 'Invalid phone number';
                            }
                            return null;
                          }
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    SizedBox(
                      width: 350,
                      child:
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.brown[100],
                            borderRadius: BorderRadius.circular(10)),
                        child:
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword1,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            contentPadding: EdgeInsets.only(left: 10),
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword1? Icons.visibility_off : Icons.visibility,
                                color: Colors.brown[800],
                              ),
                              onPressed: (){
                                setState(() {
                                  _obscurePassword1 = !_obscurePassword1;
                                }
                                );
                              },
                            ),
                          ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a password';
                              }
                              final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$');
                              if(value.length < 6){
                                return 'Password must be at least 6 characters';
                              }
                              if(!passwordRegex.hasMatch(value)){
                                return 'Your password must contain:\nan uppercase, a lowercase and a number';
                              }
                              return null;
                            }
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    SizedBox(
                      width: 350,
                      child:
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.brown[100],
                            borderRadius: BorderRadius.circular(10)),
                        child:
                        TextFormField(
                          controller: _passwordConfirmationController,
                          obscureText: _obscurePassword2,
                          decoration: InputDecoration(
                            labelText: 'Confirm the password',
                            contentPadding: EdgeInsets.only(left: 10),
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword2? Icons.visibility_off : Icons.visibility,
                                color: Colors.brown[800],
                              ),
                              onPressed: (){
                                setState(() {
                                  _obscurePassword2 = !_obscurePassword2;
                                }
                                );
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if(value != _passwordController.text){
                              return 'Passwords do not match';
                            }
                            return null;
                          }
                        ),
                      ),
                    ),
                    SizedBox(height: 60  ),
                    ElevatedButton(
                        onPressed: () async {
                          // go to home page
                          if (_formKey.currentState!.validate()) {
                            try {
                              final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              );
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(credential.user!.uid)
                                  .set({
                                'name': _nameController.text.trim(),
                                'surname': _surnameController.text.trim(),
                                'phoneNumber': _phonenumberController.text.trim(),
                                'email': _emailController.text.trim(),
                                'createdAt': Timestamp.now(),
                              });

                              // Redirection si tout se passe bien
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Landingpage()),
                              );
                            } on FirebaseAuthException catch (e) {
                              String message = 'Registration failed';
                              if (e.code == 'email-already-in-use') {
                                message =
                                'An account already exists for that email.';
                              } else if (e.code == 'weak-password') {
                                message = 'The password provided is too weak.';
                              }
                              else {
                                message = e.message ?? 'Unknown error occurred.';
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
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                        child: Text('Sign up',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white
                          ),))
                  ],
                ),
            )

          )
      ),
    );
  }
}