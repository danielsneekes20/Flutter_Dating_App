import 'package:dating_app_ikfram/components/rounded_button.dart';
import 'package:dating_app_ikfram/components/users_match.dart';
import 'package:flutter/material.dart';
import 'package:dating_app_ikfram/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dating_app_ikfram/components/current_userdata.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';

  @override
  LoginPageState createState() => LoginPageState();

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => LoginPage(),
    );
  }
}

class LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  String foutmelding = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 20.0),
            Container(
              padding: EdgeInsets.all(5.0),
              alignment: Alignment.center,
              child: Text(
                'Login',
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
            SizedBox(height: 30.0),
            TextField(
              onChanged: (value) {
                password = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password'),
            ),
            SizedBox(height: 30.0),
            RoundedButton(
                title: "Go",
                colour: Theme.of(context).accentColor,
                onPressed: () async {
                  try {
                    final User = await _auth.signInWithEmailAndPassword(
                        email: email.trim(), password: password.trim());
                    if (User != null) {
                      Usermatch.matches.clear();
                      Current_user_data.likedUserIds.clear();
                      Current_user_data.disLikedUserIds.clear();
                      Current_user_data.getCurrentUserData();
                      Usermatch.checkUserMatch();
                      Navigator.popAndPushNamed(context, '/start');
                    }
                  } catch (e) {
                    print(e);
                    String error = e.toString();
                    if (error ==
                            "[firebase_auth/invalid-email] The email address is badly formatted." ||
                        error ==
                            "[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.") {
                      foutmelding =
                          "No user found with this email. Please try again";
                    }
                    if (error ==
                            "[firebase_auth/unknown] Given String is empty or null" ||
                        error ==
                            "LateInitializationError: Field 'email' has not been initialized.") {
                      foutmelding = "Fill out both fields";
                    }
                    if (error ==
                        "[firebase_auth/wrong-password] The password is invalid or the user does not have a password.") {
                      foutmelding = "Invalid credentials. Please try again";
                    }
                    if (error ==
                        "LateInitializationError: Field 'password' has not been initialized.") {
                      foutmelding = "Fill out the password field please";
                    }
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Color(roze),
                        content: Text(
                          foutmelding,
                          style: TextStyle(color: Color(white)),
                          textAlign: TextAlign.center,
                        )));
                  }
                })
          ],
        ),
      ),
    );
  }
}
