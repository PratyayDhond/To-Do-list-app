import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/views/edit_note.dart';
import 'package:to_do_app/views/home_screen.dart';
import 'package:to_do_app/Services/theme.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // DateTime currentDate = DateTime.now();
  // print(currentDate.toString());
  runApp(MyApp());

}

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'To-do-App',
      home: HomeScreen(),
      // home: HomeScreen(),
    );
  }
}

