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
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build (BuildContext context){
    return Scaffold(
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
            SizedBox(height: 100, ),
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