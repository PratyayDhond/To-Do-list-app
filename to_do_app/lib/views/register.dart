import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/Services/sign_in_sign_out.dart';
import 'package:to_do_app/Services/theme.dart';
import 'home_screen.dart';


class RegisterScreen extends StatefulWidget{
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController email = TextEditingController();

  TextEditingController Password = TextEditingController();

  TextEditingController confirmPass = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: theme.bg_color_body,
      appBar: AppBar(
        title:  Text('Register',style: TextStyle(color: theme.text_color),),
        centerTitle: true,
        backgroundColor: theme.bg_color_appBar,
        leading: IconButton(
          color: theme.app_icon_color,
          icon: Icon(theme.dark_mode ? Icons.light_mode_sharp : Icons.dark_mode_sharp),
          onPressed: (){
            setState(() {
              theme.dark_mode = !theme.dark_mode;
              theme.setVals();
            });;
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                style: TextStyle(color: theme.text_color),
                controller: email,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Yourmail@domain.com',
                  labelStyle: TextStyle(color: theme.text_color),
                  hintStyle: TextStyle(color: theme.buttonColorSplash),
                  border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: theme.border_color)),
                ),
              ),
              SizedBox(height: 30,),
              TextField(
                style: TextStyle(color: theme.text_color),
                controller: Password,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Something hard to guess',
                  labelStyle: TextStyle(color: theme.text_color),
                  hintStyle: TextStyle(color: theme.buttonColorSplash),
                  border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: theme.border_color)),
                ),
                obscureText: true,

              ),
              SizedBox(height: 30,),
              TextField(
                style: TextStyle(color: theme.text_color),
                controller: confirmPass,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  hintText: 'Confirm Password',
                  labelStyle: TextStyle(color: theme.text_color),
                  hintStyle: TextStyle(color: theme.buttonColorSplash),
                  border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: theme.border_color)),

                ),
                obscureText: true,
              ),
              SizedBox(height: 30,),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width-210,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(theme.buttonColor),
                    foregroundColor: MaterialStateProperty.all(theme.buttonColorSplash),
                  ),
                  child: Text('Submit'),
                  onPressed: () async {
                    if(email.text == ''){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar
                          (content: Text('Email cannot be empty')
                        ),
                      );
                    }else{
                      if(Password.text.length > 6){
                        if(Password.text != confirmPass.text){
                          print('Passwords do not match');
                          return showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Passwords do not match',style: TextStyle(color: Colors.red),),
                              ));
                        }else{

                          User? result =  await auth().SignUp(email.text, Password.text,context);
                          if(result!=null){
                            print("Success");
                            print(result.email);
                            await Navigator.push(context, MaterialPageRoute(
                              builder: (context) => HomeScreen(email.text),
                            )
                            );
                            email.text = "";
                            Password.text = "";
                            confirmPass.text = "";
                          }else{
                            print('error');
                          }
                          // print('Passwords match');
                          // return showDialog(context: context,
                          //   builder: (context)=>AlertDialog(
                          //     title: Text('Passwords match'),
                          //   ),
                          // );
                        }
                      }else{
                        return showDialog(context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Password should be longer than 6 digits',style: TextStyle(color: Colors.red),),
                            )
                        );
                      }
                    }
                  },
                ),
              ),
              SizedBox(height: 20),
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text('Already Have an account? Login here',style: TextStyle(color: theme.text_color),))

            ],
          ),
        ),
      ),
    );
  }
}