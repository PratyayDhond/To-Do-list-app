import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/Services/upload.dart';

downloadData()async{
  CollectionReference data = firestore.collection('data');
  QuerySnapshot allTasks = await data.get();
  print(allTasks.size);
  allTasks.docs.forEach((DocumentSnapshot result){
    print(result.data());
  });
   // print(allTasks);
  return allTasks;
}