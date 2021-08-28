import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/Services/upload.dart';

class Note{
  String title = " ";
  String description = " ";
  String date = " ";
  String time = " ";
}

Future downloadData(email) async{
  CollectionReference data = firestore.collection('tasks').doc(email).collection('user_tasks');
  QuerySnapshot allTasks = await data.get();
  print(allTasks.size);
  var items = [];
  allTasks.docs.forEach((DocumentSnapshot result){
    print(result['title']);
    print(result['description']);
    print(result['date']);
    print(result['time']);
    Note note = new Note();
    note.title = result['title'];
    note.description = result['description'];
    note.date = result['date'];
    note.time = result['time'];
    items.add(note);
  });
   // print(allTasks);
   return items;
}