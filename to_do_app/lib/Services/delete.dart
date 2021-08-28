

import 'package:to_do_app/Services/upload.dart';

Future deleteTask(String id) async{
  try{
    await firestore.collection('tasks').doc(id).delete();
  }catch(e){
    print(e);
  }
}

