import 'package:flutter/material.dart';
import 'package:to_do_app/views/home_screen.dart';

void main() {
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
    );
  }
}

