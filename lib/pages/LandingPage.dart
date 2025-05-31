import 'package:flutter/material.dart';
import 'package:savespot_project/pages/HomePage.dart';
import 'package:savespot_project/pages/ProfilePage.dart';
import 'package:savespot_project/pages/FavoritesPage.dart';
import 'package:savespot_project/pages/SearchPage.dart';

import 'BottomBar.dart';
class Landingpage extends StatefulWidget {
  const Landingpage({super.key});

  @override
  State<Landingpage> createState() => _LandingpageState();
}

class _LandingpageState extends State<Landingpage> {
  int pageIndex = 0;

  List<Widget> get pages => [
    HomePage(onChangePage: (int index) {
      setState(() {
        pageIndex = index;
      });
    }),
    FavoritesPage(),
    SearchPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBar(
        onPageChanged: (index) {
          setState(() {
            pageIndex = index;
          });
        },
      ),
      body: pages[pageIndex],
    );
  }
}
