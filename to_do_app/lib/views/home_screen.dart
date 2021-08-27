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
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.buttonColor,
        splashColor: theme.buttonColorSplash,
        foregroundColor: theme.buttonColorSplash,

        child: Icon(Icons.note_add,color: theme.app_icon_color,size: 30,),
        onPressed: (){

        },
      ),
      appBar: AppBar(
        backgroundColor: theme.bg_color_appBar,
        title: Text('ToDo List',
          style: TextStyle(color: theme.text_color),),
        centerTitle: true,
        actions: [
          /** Theme of the app */
          theme.dark_mode?
                IconButton(onPressed: (){setState(() {
                  theme.dark_mode = !theme.dark_mode;
                  setState(() {
                    theme.setVals();
                  });
                });
                },
                    icon: Icon(Icons.light_mode, color: theme.app_icon_color,))
              : IconButton(onPressed: (){
            theme.dark_mode = !theme.dark_mode;
            setState(() {
              theme.setVals();
            });
          },
              icon: Icon(Icons.dark_mode,color: theme.app_icon_color,)),
        ],
      ),
      body: Container(
        color: theme.bg_color_body,
        ),
    );
  }
}