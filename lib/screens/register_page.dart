import 'package:dating_app_ikfram/components/models.dart';
import 'package:dating_app_ikfram/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dating_app_ikfram/constants.dart';
import 'package:dating_app_ikfram/screens/login_page.dart';
import 'package:direct_select/direct_select.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dating_app_ikfram/components/rounded_button_states.dart';

// import 'package:dating_app_ikfram/components/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  // static const String id = 'RegisterPage';
  static const String routeName = '/register';

  @override
  RegisterPageState createState() => RegisterPageState();

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => RegisterPage(),
    );
  }
}

class RegisterPageState extends State<RegisterPage> {
  bool isButtonActive = true;
  String foutmelding = "";
  final String picture =
      'https://firebasestorage.googleapis.com/v0/b/couply-4b5c9.appspot.com/o/user_1%2Fdata%2Fuser%2F0%2Fcom.example.dating_app_ikfram%2Fcache%2Fuser-5.png?alt=media&token=4f1db0e9-d8fe-401e-897a-be146888c276';
  final _auth = FirebaseAuth.instance;
  late String valueChoose;

  String userimage = 'https://firebasestorage.googleapis.com/v0/b/couply-4b5c9.appspot.com/o/user_1%2Fdata%2Fuser%2F0%2Fcom.example.dating_app_ikfram%2Fcache%2Fuser-5.png?alt=media&token=0ff59ebf-3b05-43fe-8d4c-c2315426bd79';
  var age; // age
  var Gender; // gender
  List<String> listItem = [
    "18",
    "19",
    "20",
    "21",
    "22",
    "23",
    "24",
    "25",
    "26",
    "27",
    "28"
  ];
  List<String> gender = ["Men", "Woman"];
  late String email;
  late String password;
  late String name;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    controller.addListener(() {
      final isButtonActive = controller.text.isNotEmpty;
      setState(() {
        this.isButtonActive = isButtonActive;
        //collor aanpassen:
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.0),
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 88.0),
              Container(
                padding: EdgeInsets.all(5.0),
                alignment: Alignment.center,
                child: Text(
                  'Register',
                  style: kTitleTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 48.0),
              TextField(
                onChanged: (value) {
                  email = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
              ),
              SizedBox(height: 20.0),
              TextField(
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: controller,
                onChanged: (value) {
                  name = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your displayname'),
              ),
              SizedBox(height: 20.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(white)),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          // dropdownColor: Color(white),
                          onChanged: (value) {
                            Gender = value;
                            setState(() {});
                          },
                          value: Gender,
                          items: gender.map((items) {
                            return DropdownMenuItem(
                                value: items,
                                child: Text(
                                  items,
                                  style: TextStyle(fontSize: 20),
                                ));
                          }).toList(),
                          hint: Text("Select gender"),
                          style: TextStyle(color: Color(roze)),
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(white)),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          // dropdownColor: Color(white),
                          onChanged: (value) {
                            age = value;
                            setState(() {});
                          },
                          value: age,
                          items: listItem.map((items) {
                            return DropdownMenuItem(
                                value: items,
                                child: Text(
                                  items,
                                  style: TextStyle(fontSize: 20),
                                ));
                          }).toList(),
                          hint: Text("Select age"),
                          style: TextStyle(color: Color(roze)),
                          alignment: Alignment.center,
                          dropdownMaxHeight: 200,
                          itemPadding:
                              const EdgeInsets.only(left: 30, right: 30),
                          // dropdownBorder: Border.all(color: Color(roze)),
                        ),
                      ),
                    ),
                  ]),
              SizedBox(height: 10.0),
              RoundedButton(
                  title: "Go",
                  colour: Color(roze),
                  onPressed: isButtonActive &&
                          age != null &&
                          Gender != null
                      ? () async {
                          try {
                            final newUser =
                                await _auth.createUserWithEmailAndPassword(
                                    email: email.trim(),
                                    password: password.trim());
                            final FirebaseAuth auth = FirebaseAuth.instance;
                            var collection =
                                FirebaseFirestore.instance.collection('users');
                            final User? user = auth.currentUser;

                            if (newUser != null) {
                              var catchError =
                                  collection.doc(user!.uid) // <-- Document ID
                                      .set({
                                'name': name,
                                'email': email,
                                'bio': 'busy',
                                'age': age,
                                'gender': Gender,
                                'dislikeduserid':
                                    FieldValue.arrayUnion(['111']),
                                'likeduserid': FieldValue.arrayUnion(['211']),
                                'images': FieldValue.arrayUnion([picture]),
                                'image_0': userimage,
                                'image_1': userimage,
                                'image_2': userimage,
                                'image_3': userimage,
                                'image_4': userimage,
                                'showme': 'Everybody'
                              }) // <-- Your data
                                      .then((_) => print('Added'));
                              // .catchError((error) => print('Add failed: $error'));
                              Navigator.pushNamed(context, '/login');
                            }
                          } catch (e) {
                            setState(() {
                              isButtonActive = false;
                            });
                            String error = e.toString();
                            print("hoi" + " " + error);
                            if (error ==
                                    "SPAN_EXCLUSIVE_EXCLUSIVE spans cannot have a zero length" ||
                                error ==
                                    "[firebase_auth/unknown] Given String is empty or null") {
                              foutmelding = "Please fill out every field";
                            }
                            if (error ==
                                "[firebase_auth/email-already-in-use] The email address is already in use by another account.") {
                              foutmelding = "This email is already in use";
                            }
                            if (error ==
                                "[firebase_auth/weak-password] Password should be at least 6 characters") {
                              foutmelding =
                                  "Password should be at least 6 characters";
                            }
                            if (error ==
                                "[firebase_auth/invalid-email] The email address is badly formatted.") {
                              foutmelding =
                              "This is not a valid Email";
                            }
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Color(roze),
                                content: Text(
                                  foutmelding,
                                  style: TextStyle(color: Color(white)),
                                  textAlign: TextAlign.center,
                                )));
                          }
                          controller.clear();
                        }
                      : () {
                          foutmelding = "Please fill out every field";
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Color(roze),
                              content: Text(
                                foutmelding,
                                style: TextStyle(color: Color(white)),
                                textAlign: TextAlign.center,
                              )));
                        }),
            ],
          ),
        ),
      ),
    );
  }
}
//https://firebasestorage.googleapis.com/v0/b/couply-4b5c9.appspot.com/o/user_1%2Fdata%2Fuser%2F0%2Fcom.example.dating_app_ikfram%2Fcache%2Fimage_picker1544023718157329846.jpg?alt=media&token=e096a6ed-be91-4bc1-be69-9d469433f996
