import 'package:flutter/material.dart';

class SearchResultpage extends StatefulWidget{
  const SearchResultpage({super.key});

  @override
  State<SearchResultpage> createState() => _SearchResultpageState();
}

class _SearchResultpageState extends State<SearchResultpage>{
  String name = 'Place name';
  String numberComments = '22';

  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.brown[50],
      body:
      Center(
        child:
        Column(
          children: [
            SizedBox(
              height: 70,
            ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child:
                Column(
                  children: [
                    for(int i=0; i<6; i++) ...[
                      Row(
                        children: [
                          SizedBox(width: 20,),
                          Container(
                            width: 350,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.brown[100],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: 
                            Text('  $name',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.brown[800]
                            ),),
                          ),

                        ],
                      ),
                      SizedBox(height: 20,)
        ]
                  ],
                )

              ),
          ],
        ),
      ),
    );
  }
}