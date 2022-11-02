import 'package:flutter/material.dart';
import 'package:dating_app_ikfram/constants.dart';


class CustomAppbar extends StatelessWidget implements PreferredSizeWidget  {
  final String title;
  final button;

  CustomAppbar({required this.title, this.button});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Theme
          .of(context)
          .accentColor,
      leading: button,
      title:
      Text(
      title,
    style: kHeader,
      ));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60.0);
}