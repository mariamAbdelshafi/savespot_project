import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget{
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>{
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.brown[50],
      body:
      Column(
        children: [
          SizedBox(height: 80,),
          Row(
            children: [
              SizedBox(width: 35),
              SizedBox(
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                    onPressed:() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown[100],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                    child:
                    TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.brown[800],
                        ),
                        labelText: 'Search',
                        labelStyle: TextStyle(
                          color: Colors.brown,
                          fontSize: 14,
                          fontWeight: FontWeight.bold
                        ),
                        border: InputBorder.none,
                        suffixIcon: Transform.translate(
                            offset: Offset(30, 0),
                        child:
                        IconButton(
                            onPressed: (){
                              _controller.clear();
                            },
                            icon: Icon(Icons.clear,
                            color: Colors.brown,)
                        )
                        )
                      ),
                    )
                  )
              ),
              SizedBox(width: 15),
              Container(
                width: 55,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    // open filters
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: Colors.brown[800],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.tune,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}