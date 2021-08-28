import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/Services/sign_in_sign_out.dart';
import 'package:to_do_app/Services/theme.dart';
import 'package:to_do_app/views/register.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget{
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var loading = false;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
          backgroundColor: theme.bg_color_body,
          appBar: AppBar(
            title: Text('Login',style: TextStyle(color:theme.text_color),),
            centerTitle: true,
            backgroundColor: theme.bg_color_appBar,
            leading: IconButton(
              color: theme.app_icon_color,
              icon: Icon(theme.dark_mode ? Icons.light_mode_sharp : Icons.dark_mode_sharp),
              onPressed: (){
                setState(() {
                  theme.dark_mode = !theme.dark_mode;
                  theme.setVals();
                });
              },
            ),
          ),
          body: Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: loading? Center(child: CircularProgressIndicator(color: theme.app_icon_color,),) : SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        style: TextStyle(color: theme.text_color),
                        controller: email,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: theme.app_icon_color),
                          labelText: 'Email',
                          hintText: 'yourEmail@domain.com',
                          hintStyle: TextStyle(color: theme.buttonColorSplash),
                          border: OutlineInputBorder(borderSide: BorderSide(color: theme.defaultBorder)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: theme.border_color)
                          ),
                        ),
                      ),
                      SizedBox(height: 30,),
                      TextField(
                        style: TextStyle(color: theme.text_color),
                        controller: password,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: theme.text_color),
                          hintText: 'password',
                          hintStyle: TextStyle(color: theme.text_color),

                          border: OutlineInputBorder(borderSide: BorderSide(color: theme.defaultBorder)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: theme.border_color)
                          ),
                        ),
                        obscureText: true,
                      ),
                      SizedBox(height: 30,),
                      Container(
                        height: 50,
                        width: 200,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(theme.buttonColor),
                            foregroundColor: MaterialStateProperty.all(theme.buttonColorSplash),
                          ),
                          onPressed: () async{
                            loading = true;
                            if(email.text == '' || password.text == ''){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: theme.snackBarColor,content: Text('Fields cannot be empty',style: TextStyle(color: Colors.red),)));
                            }
                            if(email.text != '' && password.text != ''){
                              setState(() {});
                              User? result = await auth().LogIn(email.text, password.text,context);
                              if(result!= null){
                                print("success");
                                await Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => HomeScreen(email.text),
                                )
                                );
                              }else{
                                print("Error");
                              }
                            }
                            loading = false;
                            setState(() {});
                            email.text = "";
                         password.text = "";
                         },
                          child: Text('Submit'),
                        ),
                      ),
                      TextButton(onPressed: () async {
                        await Navigator.push(context,MaterialPageRoute(builder: (context) => RegisterScreen()));
                        email.text = "";
                        password.text = "";
                      },
                        child: Text('New here? Register here.',style: TextStyle(color: theme.text_color),),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
    );
  }
}