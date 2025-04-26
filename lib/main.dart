import 'package:flutter/material.dart';
void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SaveSpot',
      home: StartPage(),
    );
  }
}

class StartPage extends StatelessWidget {
  const StartPage({super.key});
  @override
  Widget build (BuildContext context){
    return Scaffold(
      backgroundColor: Colors.brown[50],
      body:
        Column(
          children: [
            SizedBox(height: 100),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('lib/assets/boussole.jpg',
                width: 300,
                height: 300,
                )
              ),
            ),
            SizedBox(height: 30),
            Text(
              'SaveSpot',
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown[800]
              ),
            ),
            SizedBox(height: 10,),
            Text(
                'Save the spot',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.brown[300]
                ),
              ),

            Text(
              'Make the memory',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.brown[300]
              ),
            ),
            SizedBox(height: 60),
            Center(
                child : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: (){
                        //go to login page
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPage())
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        minimumSize: Size(300, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        )
                      ),
                      child: Text('Log In',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white
                        ),
                      )
                  ),
                  SizedBox(height: 20,),
                  ElevatedButton(
                      onPressed: (){
                        //go to register page
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegisterPage())
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown[300],
                        minimumSize: Size(300, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                      child: Text('Register',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white
                        ),)
                  ),])


            )
          ],
        ),
      );
  }
}




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
                        //go to normal page
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
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Surname',
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Username (Email)',
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Phone number',
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  obscureText: _obscurePassword1,
                  decoration: InputDecoration(
                    labelText: 'Password',
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
                SizedBox(height: 10),
                TextField(
                  obscureText: _obscurePassword2,
                  decoration: InputDecoration(
                    labelText: 'Confirm password',
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
                SizedBox(height: 100),
                ElevatedButton(
                    onPressed: (){
                      // go to profile page
                      /*Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage())
                      );*/
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

class ProfilePage extends StatelessWidget{
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[400],
        title: Center(
          child: Text('Profile page'),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 100),
            Center(
              child: Image.asset('lib/assets/profile_image.webp',
              width: 150,
              height: 150,),
            ),
            SizedBox(height: 50),
            ElevatedButton(
                onPressed: (){
                  //go to information page
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey[300],
                  minimumSize: Size(250, 50),
                ),
                child: Text('My information',
                style: TextStyle(
                  fontSize: 18,
                ),),),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: (){
                  //go to favorites page
                },
                style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey[300],
                minimumSize: Size(250, 50),
            ),
                child: Text('Favorites',
                  style: TextStyle(
                    fontSize: 18,
                  ),),),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: (){
                  //go to comments page
                },
                style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey[300],
                minimumSize: Size(250, 50),
            ),
                child: Text('My comments',
                  style: TextStyle(
                    fontSize: 18,
                  ),),),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: (){
                  //log out back to home page
                },
                style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey[300],
                minimumSize: Size(250, 50),
              ),
                child: Text('Log out',
                  style: TextStyle(
                    fontSize: 18,
                  ),),),
          ],
        ),
      ),
    );
  }
}


class InformationPage extends StatefulWidget{
  const InformationPage({super.key});

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    StartPage(),
    //FavoritesPage(),
    //SearchPage(),
    ProfilePage()
  ];

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar:
        AppBar(
          backgroundColor: Colors.grey[300],
              title: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
              child:
              Text('MY INFORMATION',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
              ),

          actions: [
            IconButton(
                onPressed: (){
                  //modification page
                },
                icon: Icon(Icons.edit))
          ],
            ),


        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            iconSize: 28,
            selectedItemColor: Colors.grey,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                    Icons.home),
                label: 'Home' ),
              BottomNavigationBarItem(
                  icon: Icon(
                      Icons.favorite),
              label: 'Favorites'),
              BottomNavigationBarItem(
                  icon: Icon(
                      Icons.search),
                  label: 'Search'),
              BottomNavigationBarItem(
                  icon: Icon(
                      Icons.person),
                  label: 'Profile'),
            ],
        ),

        //body:
            //_selectedIndex == 1? StartPage() :
            //_selectedIndex == 2? ProfilePage() :,
            //SearchPage(),

    );
  }
}