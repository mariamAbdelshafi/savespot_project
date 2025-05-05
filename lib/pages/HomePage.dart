import 'package:flutter/material.dart';
import 'package:savespot_project/pages/BottomBar.dart';
import 'package:savespot_project/pages/ProfilePage.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  //List<bool> favorites = [false, false, false, false, false];
  bool favorites = false;

  Widget build(BuildContext context){
    return Column(
      children: [
        SizedBox(height: 100,),
        Row(
            children: [
              SizedBox(width: 20,),
              Text('Discover\nnew places!',
                style: TextStyle(
                  color: Colors.brown[800],
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),),


            ]),

        SizedBox(height: 30,),
        Row(
            children: [
              SizedBox(width: 35,),
              SizedBox(
                  width: 250,

                  child:
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.brown[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:
                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.brown[800],
                        ),
                        labelText: 'Search',
                        border: InputBorder.none,
                      ),
                    ),
                  )
              ),
              SizedBox(
                width: 15,
              ),
              Container(
                  width: 55,
                  height: 55,
                  child:
                  ElevatedButton(
                      onPressed: (){
                        //open filters
                      },
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          backgroundColor: Colors.brown[800],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                      child:
                      Center(
                          child:
                          Icon(
                            Icons.tune,
                            color: Colors.white,
                            size: 25,
                          )
                      )

                  )
              ),



            ]

        ),
        SizedBox(height: 20,),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child:
          Row(
            children: [
              SizedBox(width: 10,),
              ElevatedButton(
                  onPressed: (){
                    //go to restaurant category
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child:
                  Text('Restaurants',
                    style: TextStyle(
                      color: Colors.brown[800],
                    ),)),

              SizedBox(width: 10,),
              ElevatedButton(
                  onPressed: (){
                    //go to accomodation category
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child:
                  Text('Accomodation',
                    style: TextStyle(
                      color: Colors.brown[800],
                    ),)),

              SizedBox(width: 10,),
              ElevatedButton(
                  onPressed: (){
                    //go to transportation category
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child:
                  Text('Transportation',
                    style: TextStyle(
                      color: Colors.brown[800],
                    ),)),

              SizedBox(width: 10,),
              ElevatedButton(
                  onPressed: (){
                    //go to events category
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child:
                  Text('Events',
                    style: TextStyle(
                      color: Colors.brown[800],
                    ),)),

              SizedBox(width: 10,),
              ElevatedButton(
                  onPressed: (){
                    //go to shopping category
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child:
                  Text('Shopping',
                    style: TextStyle(
                      color: Colors.brown[800],
                    ),)),

              SizedBox(width: 10,),
              ElevatedButton(
                  onPressed: (){
                    //go to fitness category
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child:
                  Text('Fitness',
                    style: TextStyle(
                      color: Colors.brown[800],
                    ),)),

              SizedBox(width: 10,),
              ElevatedButton(
                  onPressed: (){
                    //go to studies category
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child:
                  Text('Studies',
                    style: TextStyle(
                      color: Colors.brown[800],
                    ),)),
              SizedBox(width: 10,),
            ],
          ),
        ),
        SizedBox(height: 30),
        SizedBox(
          height: 200,
          child:
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child:
            Row(
              children: [
                SizedBox(width: 20,),
                Container(
                  width: 200,
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
                  ),
                ),

                SizedBox(width: 20,),
                Container(
                  width: 200,
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

                            )),

                      ),

                ),

                SizedBox(width: 20,),
                Container(
                  width: 200,
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
                  ),
                ),

                SizedBox(width: 20,),
                Container(
                  width: 200,
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
                  ),
                ),

                SizedBox(width: 20,),
                Container(
                  width: 200,
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
                  ),
                ),
                SizedBox(width: 20,),

              ],
            ),
          ),
        ),
        //SizedBox(height: 80,),
        SizedBox(height: 30,),
        Row(
          children: [
            SizedBox(width: 20,),
            Text('Last seen',
              style: TextStyle(
                  color: Colors.brown,
                  fontSize: 25,
                  fontWeight: FontWeight.bold
              ),
            ),
          ]

        ),

        SizedBox(height: 10,),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
          child:
              Row(
                children: [
                  SizedBox(width: 20,),
                  Container(
                    width: 200,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.brown[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  SizedBox(width: 20,),

                  Container(
                    width: 200,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.brown[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  SizedBox(width: 20,),

                  Container(
                    width: 200,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.brown[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  SizedBox(width: 20,),

                  Container(
                    width: 200,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.brown[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  SizedBox(width: 20,),

                  Container(
                    width: 200,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.brown[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  SizedBox(width: 20,),
                ],
              )


        ),
        ]
    );
  }
}