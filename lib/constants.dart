import 'package:flutter/material.dart';

const blueTint= 0xFF393d98;
const blue= 0xFF292C6D;
const white= 0XFFFAEDF0;
const darkblue= 0xFF0A0E21;
const roze= 0xffdb1f48;
const String startImage= 'https:firebasestorage.googleapis.com/v0/b/couply-4b5c9.appspot.com/o/user_1%2Fdata%2Fuser%2F0%2Fcom.example.dating_app_ikfram%2Fcache%2Fimage_picker1544023718157329846.jpg?alt=media&token=e096a6ed-be91-4bc1-be69-9d469433f996';

const kHeader= TextStyle(
  fontSize: 35.0,
  color: Color(white),
    fontFamily: 'Lobster'

);
const kProfUi= TextStyle(
    fontSize: 35.0,
    color: Color(white),
    fontFamily: 'Lobster'
);

const kTitleTextStyle = TextStyle(
  fontSize: 40.0,
  fontWeight: FontWeight.bold,
  color: Color(white),
  fontFamily: 'Lobster'
);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xffDB1F48), width: 3.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
