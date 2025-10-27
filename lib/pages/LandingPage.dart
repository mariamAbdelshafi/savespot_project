import 'package:flutter/material.dart';
import 'package:savespot_project/pages/HomePage.dart';
import 'package:savespot_project/pages/ProfilePage.dart';
import 'package:savespot_project/pages/FavoritesPage.dart';
import 'package:savespot_project/pages/SearchPage.dart';
import 'package:savespot_project/pages/StartPage.dart';

import 'BottomBar.dart';
class Landingpage extends StatefulWidget {
  const Landingpage({super.key});

  @override
  State<Landingpage> createState() => _LandingpageState();
}

class _LandingpageState extends State<Landingpage> {
  int pageIndex = 0;
  bool showBottomBar = true;

  final _HomepageKey = GlobalKey<NavigatorState>();
  final _FavoritesPageKey = GlobalKey<NavigatorState>();
  final _SearchPageKey = GlobalKey<NavigatorState>();
  final _ProfilePageKey = GlobalKey<NavigatorState>();



  List<Widget> get pages => [
    Navigator(
      key: _HomepageKey,
      onGenerateRoute: (route) => MaterialPageRoute(
        settings: route,
        builder: (context) => HomePage(onChangePage: (int index) {

          setState(() {
            pageIndex = index;
            showBottomBar = true;
          });
        }),
      ),
    ),
    Navigator(
      key: _FavoritesPageKey,
      onGenerateRoute: (route) => MaterialPageRoute(
        settings: route,
        builder: (context) => FavoritesPage(onChangePage: (int index) {

          setState(() {
            pageIndex = index;
            showBottomBar = true;
          });
        }),
      ),
    ),

    Navigator(
      key: _SearchPageKey,
      onGenerateRoute: (route) => MaterialPageRoute(
        settings: route,
        builder: (context) => SearchPage(onChangePage: (int index) {

          setState(() {
            pageIndex = index;
            showBottomBar = true;
          });
        }),
      ),
    ),

    Navigator(
      key: _ProfilePageKey,
      onGenerateRoute: (route) => MaterialPageRoute(
        settings: route,
        builder: (context) => ProfilePage(onChangePage: (int index) {
          setState(() {
            pageIndex = index;
            showBottomBar = true;
          });
        },
          onLogout: () {
            setState(() {
              showBottomBar = false;
            });
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => StartPage()),
            );
          },
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: showBottomBar
          ? BottomBar(
        onPageChanged: (index) {
          setState(() {
            pageIndex = index;
          });
        },
      )
          : null,
      body: pages[pageIndex],
    );
  }
}
