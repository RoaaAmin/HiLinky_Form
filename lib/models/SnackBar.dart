import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


showInSnackBar(String value,Color backgroundColor,Color textColor,int duration,BuildContext context, scaffoldKey) {
  FocusScope.of(context).requestFocus(FocusNode());// Request Keyboard to hide
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Padding(
      padding: const EdgeInsets.all(3.0),
      child: Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            fontSize: 18,
          )
      ),
    ),
    elevation: 0,
    backgroundColor: backgroundColor,
    duration: Duration(seconds: duration),
  ));
}



