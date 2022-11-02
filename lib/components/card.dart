import 'package:flutter/material.dart';
import 'package:dating_app_ikfram/constants.dart';


class Nodigcard extends StatelessWidget {
  Nodigcard ({required this.colour, required this.onPress, required this.cardChild});


  final Color colour;
  final VoidCallback onPress;
  final Widget cardChild;


  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        child: cardChild,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: colour,
          borderRadius: BorderRadius.circular(10.0),

        ),
      ),
    );
  }
}
class CardLay extends StatelessWidget {
  CardLay({required this.text,required this.icon, required this.tag});


   final String text;
   final icon;
   final tag;



  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: tag,
            child: Icon(
              icon,
              size: 80.0,
              color: Color(roze),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(text, style: TextStyle(
                color: Color(roze), fontSize: 20.0, fontWeight: FontWeight.bold
            ),
            )
            ,
          )
        ]
    );
  }
}
