import 'package:flutter/material.dart';
import 'package:savespot_project/pages/FavoritesPage.dart';
import 'package:savespot_project/pages/MyCommentsPage.dart';
import 'package:savespot_project/pages/StartPage.dart';
import 'package:savespot_project/pages/InformationPage.dart';
import 'package:savespot_project/pages/BottomBar.dart';

class ProfilePage extends StatelessWidget{
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      //bottomNavigationBar: BottomBar(),
      backgroundColor: Colors.brown[50],
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 100),
            Text('My profile',
              style: TextStyle(
                fontSize: 40,
                color: Colors.brown[800],
                fontWeight: FontWeight.bold,
              ),),
            SizedBox(height: 60,),
            Center(
              child: Image.asset('lib/assets/profile_image.webp',
                width: 150,
                height: 150,),
            ),
            SizedBox(height: 100),
            ElevatedButton(
              onPressed: (){
                //go to information page
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InformationPage())
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  minimumSize: Size(250, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  )
              ),
              child: Text('My information',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),),),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: (){
                //go to favorites page
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FavoritesPage())
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown[300],
                  minimumSize: Size(250, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  )
              ),
              child: Text('Favorites',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white
                ),),),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: (){
                //go to comment page
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyCommentsPage())
                );

              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  minimumSize: Size(250, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  )
              ),
              child: Text('My comments',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white
                ),),),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: (){
                //log out back to start page
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StartPage())
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown[300],
                  minimumSize: Size(250, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  )
              ),
              child: Text('Log out',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white
                ),),),
          ],
        ),
      ),
    );
  }
}