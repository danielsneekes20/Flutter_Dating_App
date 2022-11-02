import 'package:dating_app_ikfram/components/appbar.dart';
import 'package:dating_app_ikfram/components/users_match.dart';
import 'package:flutter/material.dart';
import 'package:dating_app_ikfram/constants.dart';
import 'package:dating_app_ikfram/components/card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dating_app_ikfram/components/users.dart';
import 'package:dating_app_ikfram/components/current_userdata.dart';

class StartPage extends StatefulWidget {
  // static const String id = 'StartPage';
  static const String routeName = '/start';

  @override
  StartPageState createState() => StartPageState();

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => StartPage(),
    );
  }
}

class StartPageState extends State<StartPage>
    with SingleTickerProviderStateMixin {
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;

  void getCurrentUser() async {
    final user = await _auth.currentUser;
    try {
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  late AnimationController controller;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  int collorSearch = blue;
  int collorHeart = blue;
  int collorSettings = blue;
  int collorPersonal = blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(title: 'Couply'),
        body: Padding(
          padding: EdgeInsets.only(top: 55.0, bottom: 55.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Row(children: <Widget>[
                  Expanded(
                      child: Nodigcard(
                    colour: Color(collorSearch),
                    onPress: () {
                      Profile.users.clear();
                      Profile.users.add(Profile(
                          id: "66",
                          name: "Start finding matches",
                          age: "",
                          image_0: startImage,
                          bio: "start",
                          interests: ['dogs'],
                          image_1: startImage,
                          image_2: startImage,
                          image_3: startImage,
                          image_4: startImage));
                      setState(() {
                        Current_user_data.getCurrentUserData();
                        Profile
                            .lijstgen(); //maakt een lijst waar de currentuser doorheen kan swipe op zoek naar matches
                        collorSearch = blueTint;
                        Navigator.pushNamed(context, '/home')
                            .then((value) => setState(() {
                                  collorSearch = blue;
                                }));
                      });
                    },
                    cardChild: CardLay(
                      tag: "",
                      text: 'Find',
                      icon: FontAwesomeIcons.search,
                    ),
                  )),
                  Expanded(
                      child: Nodigcard(
                    colour: Color(collorHeart),
                    onPress: () {
                      setState(() {
                        collorHeart = blueTint;
                        Usermatch.checkUserMatch();
                        Navigator.pushNamed(context, '/match')
                            .then((value) => setState(() {
                                  collorHeart = blue;
                                }));
                      });
                    },
                    cardChild: CardLay(
                      tag: 'logo',
                      text: "Matches",
                      icon: FontAwesomeIcons.solidHeart,
                    ),
                  )),
                ]),
              ),
              Expanded(
                child: Row(children: <Widget>[
                  Expanded(
                      child: Nodigcard(
                    colour: Color(collorSettings),
                    onPress: () {
                      setState(() {
                        collorSettings = blueTint;
                        Navigator.pushNamed(context, '/settings')
                            .then((value) => setState(() {
                                  collorSettings = blue;
                                }));
                      });
                    },
                    cardChild: CardLay(
                      tag: "",
                      text: 'Settings',
                      icon: FontAwesomeIcons.cog,
                    ),
                  )),
                  Expanded(
                    child: Nodigcard(
                        colour: Color(collorPersonal),
                        onPress: () {
                          setState(() {
                            Current_user_data.getCurrentUserData();
                            Navigator.pushNamed(context, '/personal')
                                .then((value) => setState(() {
                                      collorPersonal = blue;
                                    }));
                          });
                        },
                        cardChild: CardLay(
                          tag: "",
                          text: 'Personal',
                          icon: FontAwesomeIcons.userAlt,
                        )),
                  ),
                ]),
              ),
            ],
          ),
        ));
  }
}
