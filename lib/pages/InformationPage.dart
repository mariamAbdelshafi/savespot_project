import 'package:flutter/material.dart';
import 'package:savespot_project/pages/HomePage.dart';
import 'package:savespot_project/pages/ProfilePage.dart';

class InformationPage extends StatefulWidget{
  const InformationPage({super.key});

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  bool isEditing = false;
  bool _obscurePassword1 = true;
  bool _obscurePassword2 = true;
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _phonenumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  int _selectedIndex = 1;
  final List<Widget> _pages = [
    ProfilePage(),
    //InformationPage(),
    HomePage()
  ];

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      body:
      Column(
        children: [
          SizedBox(height: 80,),
          Row(
              children: [
                SizedBox(width: 20,),
                Text('My information',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      color: Colors.brown[800]
                  ),),
                Spacer(),
                IconButton(
                    icon: Icon(isEditing? Icons.check : Icons.edit,
                      size: 30,
                      color: Colors.brown[800],),
                    onPressed: (){
                      if(isEditing == true){
                        if(_formKey.currentState!.validate()) {
                          setState(() {
                            isEditing = false;
                          });
                        }
                      }
                      else{
                        setState(() {
                          isEditing = true;
                        });
                      }

                    }),]),
          SizedBox(height: 40,),
          Center(
            child: Image.asset('lib/assets/profile_image.webp',
              width: 150,
              height: 150,),
          ),
          SizedBox(height: 30,),
          SizedBox(
            width: 350,
            child:
                Form(
                  key: _formKey,
                    child:
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.brown[100],
                                  borderRadius: BorderRadius.circular(10)),
                              child:
                              TextFormField(
                                  controller: _nameController,
                                  enabled: isEditing,
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
                                    enabled: isEditing,
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
                                        enabled: isEditing,
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
                                        enabled: isEditing,
                                        decoration: InputDecoration(
                                          labelText: 'Number',
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
                                        enabled: isEditing,
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
                                        enabled: isEditing,
                                        decoration: InputDecoration(
                                          labelText: 'Confirm your password',
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

                          ],
                        )


                ),

          ),



          SizedBox(height: 30,),
          ElevatedButton(
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage())
                );
              },
              style: ElevatedButton.styleFrom(
              backgroundColor: Colors.brown,
              minimumSize: Size(200, 50),
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              ),
              ),
              child: Text('Go back',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20
              ),)
          ),
        ],
      ),
    );
  }
}
