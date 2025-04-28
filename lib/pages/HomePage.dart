import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.brown[50],

      body:
      Column(
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
                      //go to restaurant category
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
                      //go to restaurant category
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
                      //go to restaurant category
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
                      //go to restaurant category
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
                      //go to restaurant category
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
                      //go to restaurant category
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
                      ),))
              ],
            ),

          )
        ],
      ),
    );
  }
}