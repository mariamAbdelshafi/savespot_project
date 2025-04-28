import 'package:flutter/material.dart';
import 'package:savespot_project/pages/LoginPage.dart';
import 'package:savespot_project/pages/RegisterPage.dart';

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