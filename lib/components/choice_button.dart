

import 'package:flutter/material.dart';
import 'package:dating_app_ikfram/constants.dart';

class ChoiceButton extends StatelessWidget {
  final double width;
  final double height;
  final double size;
  final bool hasGradient;
  final Color? color;
  final IconData icon;

   ChoiceButton({
    Key? key,
    required this.width,
    required this.height,
    this.size = 25,
    this.hasGradient = false,
    required this.color,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Icon(
        icon,
        size: size,
        color: color,
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(roze),
      ),
    );
  }
}
