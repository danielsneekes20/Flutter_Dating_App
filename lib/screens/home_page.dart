import 'package:dating_app_ikfram/components/current_userdata.dart';
import 'package:flutter/material.dart';
import 'package:dating_app_ikfram/constants.dart';
import 'package:dating_app_ikfram/components/appbar.dart';
import 'package:dating_app_ikfram/components/users.dart';
import 'package:dating_app_ikfram/components/models.dart';
import 'package:dating_app_ikfram/components/choice_button.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';

  @override
  HomePageState createState() => HomePageState();

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => HomePage(),
    );
  }
}

late final Profile user;
class HomePageState extends State<HomePage> {
  int i = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Couply',button: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),),
      body: Column(
          children: [
            InkWell(
                onDoubleTap: () {
                  Navigator.pushNamed(context, '/persona',
                      arguments: Profile.users[i]);
                },
                child: UserCard(user: Profile.users[i])),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                      onTap: () {
                        setState(() {
                          Profile.disliked(Profile.users[i].id);
                          Profile.removeUser(Profile.users[i]);
                          Profile.checkempty();
                          Current_user_data.getCurrentUserData();
                          setState(() {});
                        });
                      },
                      child: ChoiceButton(
                          width: 70,
                          height: 70,
                          color: Color(white), icon: Icons.clear_rounded)),
                  InkWell(
                      onTap: () {
                        setState(() {
                          Profile.liked(Profile.users[i].id);
                          Profile.removeUser(Profile.users[i]);
                          Profile.checkempty();
                          Current_user_data.getCurrentUserData();
                          setState(() {});
                        });
                      },
                      child: ChoiceButton(
                          width:70,
                          height: 70,
                          color: Color(white), icon: Icons.favorite)),
                ],
              ),
            ),
          ],
        ),

      );
  }
}
class UserCard extends StatelessWidget {
  final Profile user;

  const UserCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 20, right: 20),
      child: SizedBox(
          height: MediaQuery.of(context).size.height / 1.4,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Hero(
                tag: 'user_image',
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(user.image_0),
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              Positioned(
                bottom: 35,
                left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${user.name}' ' ' '${user.age}',
                      style: TextStyle(fontSize: 30),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
