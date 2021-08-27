import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/Services/theme.dart';

class AddNote extends StatefulWidget{

  @override
  createState() => AddNoteState();

}

class AddNoteState extends State<AddNote>{
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.bg_color_body,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          color: theme.app_icon_color,
          iconSize: 25,
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        backgroundColor: theme.bg_color_appBar,
        centerTitle: true,
        title: Text('Add task',style: TextStyle(color: theme.text_color),),

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
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    hintText: 'e.g. Go for a walk',
                    hintStyle: TextStyle(color: theme.text_color, ),
                    labelText: 'Task title',
                    labelStyle: TextStyle(color: theme.text_color,fontWeight: FontWeight.bold),
                  ),
                ),
                 SizedBox(height: 20),
                 TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(

                    labelText: 'Task description',
                    labelStyle: TextStyle(color: theme.text_color,fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(theme.buttonColor),
                          foregroundColor: MaterialStateProperty.all(theme.buttonColorSplash),
                          shadowColor: MaterialStateProperty.all(theme.bg_color_appBar),
                          // elevation: MaterialStateProperty.all(3),
                        ),
                        onPressed: (){

                        },
                        icon: Icon(Icons.calendar_today,color: theme.app_icon_color,),
                        label: Text('Pick Date',style: TextStyle(color: theme.text_color),
                        ),
                    ),
                    ElevatedButton.icon(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(theme.buttonColor),
                          foregroundColor: MaterialStateProperty.all(theme.buttonColorSplash),
                          shadowColor: MaterialStateProperty.all(theme.bg_color_appBar),
                          // elevation: MaterialStateProperty.all(3),
                        ),
                        onPressed: (){

                        },
                        icon: Icon(Icons.watch_later_rounded,color: theme.app_icon_color,),
                        label: Text('Pick Time',style: TextStyle(color: theme.text_color),
                        ),
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }

}