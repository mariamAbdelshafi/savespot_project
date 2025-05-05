import 'package:flutter/material.dart';
import 'package:savespot_project/pages/MyCommentsPage.dart';

class PlacesPage extends StatefulWidget{
  const PlacesPage({super.key});

  @override
  State<PlacesPage> createState() => _PlacesPageState();
}

class _PlacesPageState extends State<PlacesPage>{
  bool favorites = false;
  double avgRating = 3.9;
  String address = 'address';
  String description = 'gfhgsfshfldsjdlgjlskghkjgkjghldjggjlsdhgkjdgflkjgmsjghlglsjgmsfhsfjsdgojo';
  String phoneNumber = '123456789';
  String emailAddress = 'email@gmail.com';

  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.brown[50],
      body: Center(
        child:
        Column(
          children: [
            SizedBox(height: 50,),
            SizedBox(
              height: 350,
              width: 350,
              child:
              Container(
                decoration: BoxDecoration(
                  color: Colors.brown[100],
                  borderRadius: BorderRadius.circular(30),
                ),
                child:
                Align(
                  alignment: Alignment.bottomRight,
                  child:
                  FilledButton(
                      onPressed: (){
                        //put to favorites
                        setState(() {
                          favorites = !favorites;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(30, 30),
                        backgroundColor: Colors.transparent,
                      ),
                      child:
                      Icon(
                        favorites? Icons.favorite : Icons.favorite_border,
                        color: favorites? Colors.white : Colors.white,
                        size: 25,

                      )
                ),


              )
              ,
            )
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                SizedBox(width: 30,),
                Text('Place name',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown[800]
                  ),
                ),
                Spacer(),
                SizedBox(
                  height: 20,
                  width: 50,
                  child:
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.amber[50],
                        borderRadius: BorderRadius.circular(30)
                      ),
                      child:
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 20,
                              ),
                              SizedBox(width: 5,),
                              Text('$avgRating'),
                            ],
                          ),
                    ),
                ),
                SizedBox(width: 20,),

              ],
            ),
            Row(
              children: [
                SizedBox(width: 35,),
                Icon(
                  Icons.place,
                  size: 20,
                  color: Colors.brown,
                ),
                Text('$address'),
              ],
            ),

            SizedBox(height: 20,),
            Row(
              children: [
                SizedBox(width: 30,),
                Text('Description',
                  style: TextStyle(
                      color: Colors.brown[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 330,
              height: 70,
              child:
              Text('$description'),
            ),

            SizedBox(height: 20,),
            Row(
              children: [
                SizedBox(width: 30,),
                Text('Contact',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                  ),)
              ],
            ),
            SizedBox(height: 5,),
            Row(
              children: [
                SizedBox(width: 30,),
                Icon(
                  Icons.phone,
                  color: Colors.brown,
                ),
                SizedBox(width: 15,),
                Text('$phoneNumber'),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 30,),
                Icon(
                  Icons.email,
                  color: Colors.brown,
                ),
                SizedBox(width: 15,),
                Text('$emailAddress'),
              ],
            ),

            SizedBox(height: 40,),
            Align(
              alignment: Alignment.bottomRight,
              child:
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                  onPressed: (){
                    //go to comment page
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyCommentsPage())
                    );
                  },
                  child:
                  Text('See comments',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15
                  ),))
            )


          ],
        ),
      ),
    );
  }
}