/*import 'package:flutter/material.dart';
import 'package:savespot_project/pages/LandingPage.dart';
import 'package:savespot_project/pages/BottomBar.dart';
import 'package:savespot_project/pages/HomePage.dart';
import 'package:savespot_project/pages/FavoritesPage.dart';
import 'package:savespot_project/pages/ProfilePage.dart';

class BottomBarWrapper extends StatefulWidget {
  final Widget child;
  final int initialIndex;

  const BottomBarWrapper({
    Key? key,
    required this.child,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  State<BottomBarWrapper> createState() => _BottomBarWrapperState();
}

class _BottomBarWrapperState extends State<BottomBarWrapper> {
  late int pageIndex;

  final List<Widget> _pages = [
    HomePage(),
    FavoritesPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    pageIndex = widget.initialIndex;
  }

  void _onTabTapped(int index) {
    if (index < _pages.length) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Landingpage(initialIndex: index),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomBar(
        currentIndex: pageIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}*/
