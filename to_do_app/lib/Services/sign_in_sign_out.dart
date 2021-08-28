import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'theme.dart';

class auth{
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future<User?> SignUp(String email,String Password,BuildContext context) async {
      try{
        UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: Password);
        return userCredential.user;
      } on FirebaseException catch(e){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      }catch(e){
        print(e);
      }

  }

  Future<User?> LogIn(String email, String password, BuildContext context) async {
    try{
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    }on FirebaseAuthException catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.black,content: Text(e.code,style: TextStyle(color: Colors.redAccent),)));
    }catch(e){
      print(e);
    }
  }

}