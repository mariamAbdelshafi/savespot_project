import 'package:flutter/material.dart';

class MyCommentsPage extends StatefulWidget{
  const MyCommentsPage({super.key});

  @override
  State<MyCommentsPage> createState() => _MyCommentsPageState();
}

class _MyCommentsPageState extends State<MyCommentsPage>{
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.brown[50],
    );
  }
}