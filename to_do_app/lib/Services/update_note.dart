

import 'package:to_do_app/Services/upload.dart';

Future updateTask(String id, String title, String description,email) async{
  try{
    await firestore.collection('tasks').doc(email).collection('user_tasks').doc(id).update({
      'title' : title,
      'description' : description
    });
  }catch(e){
    print(e);
  }
}

