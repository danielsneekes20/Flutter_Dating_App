import 'package:dating_app_ikfram/components/appbar.dart';
import 'package:flutter/material.dart';
import 'package:dating_app_ikfram/constants.dart';
import 'package:dating_app_ikfram/components/rounded_button.dart';


class WelkomPage extends StatefulWidget {
  static const String routeName = '/';

  @override
  WelkomPageState createState() => WelkomPageState();

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => WelkomPage(),
    );
  }
}

class WelkomPageState extends State<WelkomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Couply'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: Text(
                'Welcome to Couply, lets start finding your perfect match',
                style: kTitleTextStyle,
              ),
            ),
            SizedBox(height: 100.0),
            RoundedButton(
              title: "Login",
              colour: Theme.of(context).accentColor,
              onPressed: () {
                Navigator.popAndPushNamed(context, '/login');
              },
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  Navigator.pushNamed(context, '/register');
                });
              },
              child: Text("Not a account? Register here",
                  style: TextStyle(color: Color(roze)),
                  textAlign: TextAlign.center),
            )
          ],
        ),
      ),
    );
  }
}
