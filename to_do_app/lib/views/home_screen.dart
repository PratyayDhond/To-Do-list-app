import 'package:flutter/material.dart';
import 'package:to_do_app/Services/theme.dart';
class HomeScreen extends StatefulWidget{
  @override
  createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.bg_color_appBar,
        title: Text('ToDo List',
          style: TextStyle(color: theme.text_color),),
      ),
    );
  }
}