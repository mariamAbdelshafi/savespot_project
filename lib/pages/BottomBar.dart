import 'package:flutter/material.dart';
import 'package:savespot_project/pages/HomePage.dart';
import 'package:savespot_project/pages/ProfilePage.dart';
import 'package:savespot_project/pages/FavoritesPage.dart';
import 'package:savespot_project/pages/SearchPage.dart';

class BottomBar extends StatefulWidget{
  const BottomBar({super.key, required this.onPageChanged});
  final void Function(dynamic index) onPageChanged;

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar>{
  int selectedIndex = 0;

  final List<Widget> _pages = <Widget>[
    HomePage(),
    FavoritesPage(),
    SearchPage(),
    ProfilePage(),

  ];

  void onItemTap(int index){
      setState(() {
        selectedIndex = index;
      });
      widget.onPageChanged(
        selectedIndex,
      );
  }


  @override
  Widget build(BuildContext context){
    return BottomNavigationBar(
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
      currentIndex: selectedIndex,
      onTap: onItemTap,
    );
  }
}