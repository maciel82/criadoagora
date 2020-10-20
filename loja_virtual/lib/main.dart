import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color.fromARGB(255, 4, 155, 121),      
      ),
      home: HomeScreen()
    );
  }
}