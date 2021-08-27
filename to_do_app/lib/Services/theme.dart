import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class theme{
  static var dark_mode = false;
  static var bg_color_appBar = Colors.white;
  static var bg_color_body = Colors.white;
  static var text_color = Colors.black;
  static var drawer_bg_color = Colors.white;
  static var drawer_icon_color = Colors.black;
  static var app_icon_color = Colors.black;
  static var divider_color = Colors.black26;
  static var search_bar = HexColor('#ff404040');
  static var border_color = Colors.black;
  static var cursor_color = Colors.black;
  static var buttonColor = Colors.white70;
  static var buttonColorSplash = Colors.black45;
  static var card_color = HexColor('#ff595959');

  static setVals(){
    if(dark_mode){
      bg_color_appBar = Colors.black;
      bg_color_body = HexColor('#ff1a1a1a');
      text_color = Colors.white;
      drawer_bg_color = HexColor('#ff1a1a1a');
      drawer_icon_color = Colors.white;
      app_icon_color = Colors.white;
      divider_color = Colors.white24;
      cursor_color = Colors.white;
      border_color = Colors.white;
      buttonColor = Colors.black54;
      buttonColorSplash = Colors.white70;

    }else{
      buttonColor = Colors.white70;
      buttonColorSplash = Colors.black45;
      bg_color_appBar = Colors.white;
      bg_color_body = Colors.white;
      text_color = Colors.black;
      drawer_bg_color = HexColor('#ffffffff');
      drawer_icon_color = Colors.black;
      app_icon_color = Colors.black;
      divider_color = Colors.black26;
      cursor_color = Colors.black26;
      border_color = Colors.black;
    }
  }

}