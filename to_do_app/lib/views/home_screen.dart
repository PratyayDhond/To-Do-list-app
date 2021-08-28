import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/Services/delete.dart';
import 'package:to_do_app/Services/download.dart';
import 'package:to_do_app/Services/theme.dart';
import 'package:to_do_app/Services/update_note.dart';
import 'package:to_do_app/views/add_note.dart';
import 'package:to_do_app/views/edit_note.dart';

class HomeScreen extends StatefulWidget{
  HomeScreen(email){
    theme.email = email;
  }
  @override
  createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: theme.bg_color_body,
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.buttonColor,
        splashColor: theme.buttonColorSplash,
        foregroundColor: theme.buttonColorSplash,
        child: Icon(Icons.note_add,color: theme.app_icon_color,size: 30,),
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(
            builder: (context) => AddNote(theme.email),
          ),
          );
          setState(() {});
        },
      ),
      appBar: AppBar(
        leading: IconButton(onPressed: (){setState(() {
          theme.dark_mode = !theme.dark_mode;
          setState(() {
            theme.setVals();
          });
        });
        },
            icon: Icon(theme.dark_mode?Icons.light_mode:Icons.dark_mode, color: theme.app_icon_color,)),

        backgroundColor: theme.bg_color_appBar,
        title: Text('ToDo app',
          style: TextStyle(color: theme.text_color),),
        centerTitle: true,
        actions: [
          ElevatedButton.icon(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(theme.bg_color_appBar),
            ),
            onPressed: (){
              Navigator.pop(context);
              setState(() {
                theme.isLoggedIn = !theme.isLoggedIn;
              });
            },
            icon: Icon( Icons.logout_sharp, color:Colors.grey[700]),
            label: Text( 'Log out' ,style: TextStyle(color: theme.text_color),),

          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('tasks').doc(theme.email).collection('user_tasks').snapshots(),
        builder: (context, AsyncSnapshot snapshot){
          if(snapshot.hasData){
            if(snapshot.data.docs.length > 0){
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ListTile(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                          tileColor: theme.card_color,
                          onTap: (){
                            showDialog(
                                context: context,
                                builder: (context){
                                  return SimpleDialog(
                                    backgroundColor: theme.bg_color_body,
                                    title: Container(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(width: MediaQuery.of(context).size.width/2 +10,),
                                              IconButton(onPressed: ()async{
                                                Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) => EditTask(snapshot.data.docs[index].id,snapshot.data.docs[index]['title'], snapshot.data.docs[index]['description'])
                                                  ),
                                                );
                                              }, icon: Icon(Icons.edit, color: theme.dark_mode ? Colors.yellowAccent : Colors.black, size: 30,)),
                                            ],
                                          ),
                                          Divider(color: theme.divider_color,),
                                          Row(

                                            children: [
                                              Flexible(child: Text(snapshot.data.docs[index]['title'],style: TextStyle(color: theme.text_color),overflow: TextOverflow.visible,)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    children: [
                                      Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            Text(snapshot.data.docs[index]['description'], style: TextStyle(color: theme.text_color,wordSpacing: 1.5,fontSize: 16),),
                                            SizedBox(height: 8,),
                                            Text('Deadline on ${snapshot.data.docs[index]['date']} at ${snapshot.data.docs[index]['time']}',
                                              style: TextStyle(color: theme.text_color),
                                            ),
                                          ],

                                        ),
                                      )


                                    ],


                                  );
                                }
                            );
                          },
                          title: Text(snapshot.data.docs[index]['title'],style: TextStyle(color: theme.text_color,fontWeight: FontWeight.bold),),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10,),
                              Text(snapshot.data.docs[index]['description'], style: TextStyle(color: theme.text_color),),
                              SizedBox(height: 5,),
                            ],
                          ),

                          leading: IconButton(
                              onPressed: (){
                                deleteTask(snapshot.data.docs[index].id);
                              },
                              icon: Icon(Icons.check_circle,color: theme.dark_mode?Colors.greenAccent[700] : Colors.green[700] ,)
                          ),
                        ),
                      ),
                    );
                  }
              );
            }
            return Center(child: Text('No Tasks found',style: TextStyle(color: theme.app_icon_color),),);
          }
          return Center(child: CircularProgressIndicator(color: theme.app_icon_color,),);

        },
      ),
    );
  }
}