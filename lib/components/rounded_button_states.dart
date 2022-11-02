import 'package:flutter/material.dart';

class RoundedButtonState extends StatelessWidget {
  RoundedButtonState({required this.title, required this.colour, required this.onPressed});

  final Color colour;
  final String title;
  final void onPressed;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: (){

          },
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0
            ),
          ),
        ),
      ),
    );
  }


}
