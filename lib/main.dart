import 'package:flutter/material.dart';
import 'package:savespot_project/pages/LandingPage.dart';
import 'package:savespot_project/pages/PlacesPage.dart';
import 'package:savespot_project/pages/SearchResultPage.dart';
import 'package:savespot_project/pages/StartPage.dart';
import 'package:savespot_project/pages/HomePage.dart';
import 'package:savespot_project/pages/LoginPage.dart';
import 'package:savespot_project/pages/RegisterPage.dart';
import 'package:savespot_project/pages/ProfilePage.dart';
import 'package:savespot_project/pages/InformationPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SaveSpot',
      home: StartPage(),
    );
  }
}