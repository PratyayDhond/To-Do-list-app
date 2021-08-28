import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/Services/theme.dart';
import 'package:to_do_app/Services/upload.dart';

class AddNote extends StatefulWidget{
  String? email = "";
  AddNote(this.email);
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  createState() => AddNoteState();

}

class AddNoteState extends State<AddNote>{
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.SubmitColor,
        foregroundColor: Colors.greenAccent,
        splashColor: Colors.lightGreenAccent,
        onPressed: ()async{
            await uploadData(titleController.text, descriptionController.text,SelectedDate,SelectedTime,widget.email);
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
              content: Text('Task Created Successfully'),
            ),
            );
         },
        child: Icon(Icons.task,color: Colors.black,),
      ),
      body:Container(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
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
                        onPressed: ()async{
                          await _selectDate(context);
                          print(SelectedDate);
                        },
                        icon: Icon(Icons.calendar_today,color: theme.app_icon_color,),
                        label: Text(SelectedDate == null ? 'Pick Date' : '$SelectedDate',style: TextStyle(color: theme.text_color),
                        ),
                    ),
                    ElevatedButton.icon(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(theme.buttonColor),
                          foregroundColor: MaterialStateProperty.all(theme.buttonColorSplash),
                          shadowColor: MaterialStateProperty.all(theme.bg_color_appBar),
                          // elevation: MaterialStateProperty.all(3),
                        ),
                        onPressed: ()async{
                          await _selectTime(context);
                        },
                        icon: Icon(Icons.watch_later_rounded,color: theme.app_icon_color,),
                        label: Text(SelectedTime == null ? 'Pick Time' : '$SelectedTime',style: TextStyle(color: theme.text_color),
                        ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  var currentDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        String date = pickedDate.toString().substring(0,10);
        SelectedDate = date;
      });
    }

    Future<void> _selectTime(BuildContext context) async {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if(pickedTime != null && pickedTime != TimeOfDay.now() || SelectedDate != DateTime.now().toString().substring(0,10)){
        String time = pickedTime.toString().substring(10,15);
        print(time);
        setState(() {
          SelectedTime = time;
        });
      }
      if (pickedTime != null && pickedTime == TimeOfDay.now() && SelectedDate == DateTime.now().toString().substring(0,10)) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: theme.dark_mode? Colors.black : Colors.white,
              content: Text('Time cannot be set to present time',
                    style: TextStyle(color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
              )
          )
        );
      }
    }

}

