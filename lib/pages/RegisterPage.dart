import 'package:flutter/material.dart';
import 'package:savespot_project/pages/HomePage.dart';

class RegisterPage extends StatefulWidget{
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>{
  bool _obscurePassword1 = true;
  bool _obscurePassword2 = true;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.brown[50],
      body: Center(
          child:
          SizedBox(
            width: 300,
            child: Column(
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
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Name',
                        contentPadding: EdgeInsets.only(left: 10),
                        border: InputBorder.none,
                      ),
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
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Surname',
                        contentPadding: EdgeInsets.only(left: 10),
                        border: InputBorder.none,
                      ),
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
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Username',
                        contentPadding: EdgeInsets.only(left: 10),
                        border: InputBorder.none,
                      ),
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
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        contentPadding: EdgeInsets.only(left: 10),
                        border: InputBorder.none,
                      ),
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
                    TextField(
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
                    TextField(
                      obscureText: _obscurePassword2,
                      decoration: InputDecoration(
                        labelText: 'Password',
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
                    ),
                  ),
                ),
                SizedBox(height: 100),
                ElevatedButton(
                    onPressed: (){
                      // go to profile page
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage())
                      );
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
      ),
    );
  }
}