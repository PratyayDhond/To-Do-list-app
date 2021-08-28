

import 'package:to_do_app/Services/upload.dart';

Future updateTask(String id, String title, String description) async{
  try{
    await firestore.collection('tasks').doc(id).update({
      'title' : title,
      'description' : description
    });
  }catch(e){
    print(e);
  }
}

