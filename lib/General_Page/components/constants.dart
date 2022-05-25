import 'package:flutter/material.dart';

const primaryColor = Colors.white; //Color(0xffececea);
const buttonColor = Colors.lightBlueAccent;
const bigTextColor = Color(0xff505050);
const menuColor = Color(0xffececea);
const textColor = Color(0xffececea);
const borderColor = Color(0xffe3e3e1);
const boxColor = Colors.lightBlueAccent;//Color(0xffbdbdc7);
const detailsTextColor = Color(0xff505050);
const cardColor = Colors.white12;
const activeButton = boxColor;
const disabledButton= primaryColor;

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
const kAdminFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
);

const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 100.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 55.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 25.0,
  fontFamily: 'Spartan MB',
  color: Colors.white
);

const kConditionTextStyle = TextStyle(
  fontSize: 100.0,
);
const kInputDecorationStyle = InputDecoration(
    filled: true,
    fillColor: Colors.white54,
    icon: Icon(
      Icons.location_city,
      color: Colors.white,
    ),
    hintStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.normal
    ),
    hintText : 'Enter City Name',
    border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0),),
    )
);