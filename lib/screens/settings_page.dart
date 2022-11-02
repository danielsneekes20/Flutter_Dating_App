import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app_ikfram/components/appbar.dart';
import 'package:dating_app_ikfram/components/rounded_button.dart';
import 'package:dating_app_ikfram/screens/personal_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dating_app_ikfram/constants.dart';
import 'package:dating_app_ikfram/screens/home_page.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class SettingsPage extends StatefulWidget {
  // static const String id = 'SettingsPage';
  static const String routeName = '/settings';

  @override
  SettingsPageState createState() => SettingsPageState();

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => SettingsPage(),
    );
  }
}

class SettingsPageState extends State<SettingsPage> {
  @override
  final _firestore = FirebaseFirestore.instance;
  List<String> gender = ["Men", "Woman", 'Everybody'];
  String location = "Amsterdam";
  static var Showme;
  RangeValues values = RangeValues(18, 100);
  RangeLabels labels = RangeLabels('18', '100');
  double value1 = 50;
  static late String bbio;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Couply',button: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                height: MediaQuery.of(context).size.height / 12,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(blueTint),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text('Show me:',
                          style:
                              TextStyle(color: Color(white), fontSize: 20.0)),
                    ),
                    DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        hint: Text("Select gender"),
                        style: TextStyle(color: Color(white), fontSize: 20.0),
                        // dropdownColor: Color(roze),
                        onChanged: (value) {
                          Showme = value.toString();
                          showme();
                          setState(() {});
                        },
                        value: Showme,
                        items: gender.map((items) {
                          return DropdownMenuItem(
                              value: items, child: Text(items));
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                height: MediaQuery.of(context).size.height / 6,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(blueTint),
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Age',
                        style: TextStyle(
                            color: Color(white),
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SliderTheme(
                      data: SliderThemeData(
                          showValueIndicator: ShowValueIndicator.always),
                      child: RangeSlider(
                          activeColor: Color(roze),
                          inactiveColor: Color(white),
                          labels: labels,
                          max: 100,
                          min: 18,
                          values: values,
                          onChanged: (value) {
                            setState(() {
                              values = value;
                              labels = RangeLabels(
                                  value.start.toInt().toString(),
                                  value.end.toInt().toString());
                            });
                          }),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                height: MediaQuery.of(context).size.height / 6,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(blueTint),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text('Max distance',
                          style:
                              TextStyle(color: Color(white), fontSize: 20.0)),
                    ),
                    SliderTheme(
                      data: SliderThemeData(
                          showValueIndicator: ShowValueIndicator.always),
                      child: Slider(
                          activeColor: Color(roze),
                          min: 10,
                          max: 50,
                          value: value1,
                          onChanged: (value) {
                            setState(() {
                              value1 = value;
                            });
                          }),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                height: MediaQuery.of(context).size.height / 12,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(blueTint),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('Location :',
                      style: TextStyle(color: Color(white), fontSize: 20.0)),
                ),
              ),
              RoundedButton(
                  title: 'Log Out',
                  colour: Color(roze),
                  onPressed: () {
                    PersonalPageState.images
                        .clear(); // als je uitlogd worden je pf fotos verwijderd
                    FirebaseAuth.instance.signOut();
                    Phoenix.rebirth(context);
                  })
            ],
          ),
        ),
      ),
    );
  }

  showme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('showme', Showme);
    } catch (e) {
      print(e);
    }
  }
}
