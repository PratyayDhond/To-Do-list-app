import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/Services/theme.dart';
import 'package:to_do_app/Services/update_note.dart';
import 'package:to_do_app/Services/upload.dart';

class EditTask extends StatefulWidget{
  String title,description;
  String id;
  EditTask(this.id,this.title,this.description);
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  createState() => EditTaskState(title,description);

}

class EditTaskState extends State<EditTask>{
  EditTaskState(String title,String description){
    titleController.text = title;
    descriptionController.text = description;
  }
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  var SelectedDate;
  var SelectedTime;
  var loading = false;

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
        title: Text('ToDo App',style: TextStyle(color: theme.text_color),),

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
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.SubmitColor,
        foregroundColor: Colors.greenAccent,
        splashColor: Colors.lightGreenAccent,
        onPressed: ()async{
          await updateTask(widget.id,titleController.text,descriptionController.text,theme.email);
          Navigator.pop(context);
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Task Updated Successfully'),
            ),
          );
        },
        child: Icon(Icons.update,color: Colors.black,),
      ),
      body:Container(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: 25,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      child: Text('Update Task',style: TextStyle(fontSize: 25, color: theme.text_color,fontWeight: FontWeight.bold ),)),

                ],
              ),
              SizedBox(height: 25,),
              TextFormField(
                style: TextStyle(color: theme.text_color),
                controller: titleController,

                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: theme.app_icon_color)
                  ),
                  hintText: 'e.g. Go for a walk',
                  hintStyle: TextStyle(color: theme.text_color, ),
                  labelText: 'Task title',
                  labelStyle: TextStyle(color: theme.text_color,fontWeight: FontWeight.bold),
                ),
                maxLength: 50,
              ),
              TextFormField(
                style: TextStyle(color: theme.text_color),
                controller: descriptionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: theme.app_icon_color)
                  ),
                  labelText: 'Task description',
                  labelStyle: TextStyle(color: theme.text_color,fontWeight: FontWeight.bold),
                ),
                maxLines: 3,
                maxLength: 1000,
              ),
              SizedBox(height: 30),

            ],
          ),
        ),
      ),
    );
  }

}

