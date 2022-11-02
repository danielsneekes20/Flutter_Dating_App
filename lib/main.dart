import 'package:dating_app_ikfram/components/models.dart';
import 'package:dating_app_ikfram/components/users.dart';
import 'package:dating_app_ikfram/screens/welkom_page.dart';
import 'package:flutter/material.dart';
import 'package:dating_app_ikfram/screens/login_page.dart';
import 'package:dating_app_ikfram/screens/register_page.dart';
import 'package:dating_app_ikfram/screens/home_page.dart';
import 'package:dating_app_ikfram/screens/persona_page.dart';
import 'package:dating_app_ikfram/screens/start_page.dart';
import 'package:dating_app_ikfram/screens/settings_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import'package:dating_app_ikfram/screens/match_page.dart';

import 'package:flutter/services.dart';
import 'package:dating_app_ikfram/constants.dart';
import 'package:dating_app_ikfram/components/route_gen.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';


// void main()=> runApp(Dating_app());
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Phoenix(
      child: Dating_app()));
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Color(0xFF0A0E21),
  ));
}

class Dating_app extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    // home: WelkomPage(),
      initialRoute: WelkomPage.routeName,
      onGenerateRoute: RouteGenerator.onGenerateRoute,
      title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          primaryColor: Color(0xFF0A0E21),
          accentColor: Color(0xffdb1f48),
          scaffoldBackgroundColor: Color(0xFF0A0E21),
        ),
      home: WelkomPage(),
    );
  }
}






