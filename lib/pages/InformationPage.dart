import 'package:flutter/material.dart';

class InformationPage extends StatefulWidget{
  const InformationPage({super.key});

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  bool _obscurePassword = true;
  bool isEditing = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      body :
      Column(
        children: [
          SizedBox(height: 80,),
          Row(
              children: [
                SizedBox(width: 20,),
                Text('My information',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      color: Colors.brown[800]
                  ),),
                Spacer(),
                IconButton(
                    icon: Icon(isEditing? Icons.check : Icons.edit,
                      size: 30,
                      color: Colors.brown[800],),
                    onPressed: (){
                      setState(() {
                        isEditing = !isEditing;
                      });
                    }),]),
          SizedBox(height: 50,),
          SizedBox(
            width: 350,
            child:
            Container(
              decoration: BoxDecoration(
                  color: Colors.brown[100],
                  borderRadius: BorderRadius.circular(10)),
              child:
              TextField(
                enabled: isEditing,
                decoration: InputDecoration(
                  labelText: 'Name',
                  contentPadding: EdgeInsets.only(left: 10),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          SizedBox(height: 15,),
          SizedBox(
            width: 350,
            child:
            Container(
              decoration: BoxDecoration(
                  color: Colors.brown[100],
                  borderRadius: BorderRadius.circular(10)),
              child:
              TextField(
                enabled: isEditing,
                decoration: InputDecoration(
                  labelText: 'Surname',
                  contentPadding: EdgeInsets.only(left: 10),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),


          SizedBox(height: 15,),
          SizedBox(
            width: 350,
            child:
            Container(
              decoration: BoxDecoration(
                  color: Colors.brown[100],
                  borderRadius: BorderRadius.circular(10)),
              child:
              TextField(
                enabled: isEditing,
                decoration: InputDecoration(
                  labelText: 'Email',
                  contentPadding: EdgeInsets.only(left: 10),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          SizedBox(height: 15,),
          SizedBox(
            width: 350,
            child:
            Container(
              decoration: BoxDecoration(
                  color: Colors.brown[100],
                  borderRadius: BorderRadius.circular(10)),
              child:
              TextField(
                enabled: isEditing,
                decoration: InputDecoration(
                  labelText: 'Number',
                  contentPadding: EdgeInsets.only(left: 10),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          SizedBox(height: 15,),
          SizedBox(
            width: 350,
            child:
            Container(
              decoration: BoxDecoration(
                  color: Colors.brown[100],
                  borderRadius: BorderRadius.circular(10)),
              child:
              TextField(
                enabled: isEditing,
                decoration: InputDecoration(
                  labelText: 'Birthdate',
                  contentPadding: EdgeInsets.only(left: 10),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          SizedBox(height: 15,),
          SizedBox(
            width: 350,
            child:
            Container(
              decoration: BoxDecoration(
                  color: Colors.brown[100],
                  borderRadius: BorderRadius.circular(10)),
              child:
              TextField(
                obscureText: _obscurePassword,
                enabled: isEditing,
                decoration: InputDecoration(
                  labelText: 'Password',
                  contentPadding: EdgeInsets.only(left: 10),
                  border: InputBorder.none,
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
            ),
          )
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        iconSize: 28,
        selectedItemColor: Colors.brown[800],
        unselectedItemColor: Colors.brown[800],
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.brown[800],),
            label: 'Home' ,),
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.favorite,
                  color: Colors.brown[800]),
              label: 'Favorites'),
          BottomNavigationBarItem(
            icon: Icon(
                Icons.search,
                color: Colors.brown[800]),
            label: 'Search',),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Colors.brown[800],),
              label: 'Profile'),
        ],
      ),
    );
  }
}
