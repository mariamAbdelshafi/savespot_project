import 'package:flutter/material.dart';
void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SaveSpot',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: ProfilePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build (BuildContext context){
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 100),
            Text(
                'SaveSpot',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 50),
            Text(
              textAlign: TextAlign.center,
              'Are you a new student in Turkey?\n'
                  'Then you are in the right place!\n'
                  'Find all the good spots, and all you need in SaveSpot!',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 100),
            Center(
              child: Image.asset('lib/assets/erasmus.jpg'),
            ),
            SizedBox(height: 100),
            Center(
                child : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: (){
                        //go to login page
                      },
                      child: Text('Log In')
                  ),
                  SizedBox(width: 100),
                  ElevatedButton(
                      onPressed: (){
                        //go to register page
                      },
                      child: Text('Register')
                  ),])


            )
          ],
        ),
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
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[400],
        title: Center(
          child: Text('LOGIN PAGE'))
      ),
      body: Center(
        child: Container(
          width: 300,
            child: Column(
                children: [
                  SizedBox(height: 150),
                  Text('Welcome Back!',
                  style:
                  TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),),
                  SizedBox(height: 100),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        //go to normal page
                      }, child: Text('LOGIN')),
                  TextButton(
                      onPressed: (){
                        //reset password
                      },
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      )),
                  SizedBox(height: 200),
                  Text("You don't have an account?"),
                  TextButton(
                      onPressed: (){
                        //register page
                      }, 
                      child: Text('Sign up',
                      style: TextStyle(
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
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
          backgroundColor: Colors.blueGrey[400],
          title: Center(
            child: Text('REGISTER PAGE')
          )
      ),
      body: Center(
        child: Container(
          width: 300,
            child: Column(
              children: [
                SizedBox(height: 100),
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
                    labelText: 'Password',
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Confirm password',
                  ),
                ),
                SizedBox(height: 100),
                ElevatedButton(
                    onPressed: (){
                      // go to profile page
                    },
                    child: Text('Sign up'))
              ],
            ),
        )
      ),
    );
  }
}

class ProfilePage extends StatelessWidget{
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
                child: Text('My information',
                style: TextStyle(
                  fontSize: 18,
                ),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey[300],
                  minimumSize: Size(250, 50),
                ),),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: (){
                  //go to favorites page
                },
                child: Text('Favorites',
                  style: TextStyle(
                    fontSize: 18,
                  ),),
                style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey[300],
                minimumSize: Size(250, 50),
            ),),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: (){
                  //go to comments page
                },
                child: Text('My comments',
                  style: TextStyle(
                    fontSize: 18,
                  ),),
                style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey[300],
                minimumSize: Size(250, 50),
            ),),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: (){
                  //log out back to home page
                },
                child: Text('Log out',
                  style: TextStyle(
                    fontSize: 18,
                  ),),
                style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey[300],
                minimumSize: Size(250, 50),
              ),),
          ],
        ),
      ),
    );
  }
}