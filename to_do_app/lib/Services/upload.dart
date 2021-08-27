
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

uploadData(String title, String description,String date,String time)async{
  CollectionReference data = firestore.collection('tasks');
  await data.add({
    'title' : title,
    'description': description,
    'time':time,
    'date':date,
    'timestamp': DateTime.now()
  });
}
