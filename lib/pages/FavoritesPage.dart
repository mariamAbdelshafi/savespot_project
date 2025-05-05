import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget{
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage>{
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.brown[50],
    );
  }
}