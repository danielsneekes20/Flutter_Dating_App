import 'package:dating_app_ikfram/components/appbar.dart';
import 'package:dating_app_ikfram/components/user_image_small.dart';
import 'package:dating_app_ikfram/components/users_match.dart';
import 'package:flutter/material.dart';
import 'package:dating_app_ikfram/constants.dart';

class MatchPage extends StatefulWidget {
  static const String routeName = '/match';

  @override
  MatchPageState createState() => MatchPageState();

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => MatchPage(),
    );
  }
}

class MatchPageState extends State<MatchPage> {
  @override
  Widget build(BuildContext context) {
    // List<Profile> matches= Usermatch.matches;
    return Scaffold(
      appBar: CustomAppbar(title: 'Couply'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Matches',
                style: kTitleTextStyle.copyWith(fontSize: 30),
              ),
              SizedBox(
                height: 280,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        UserImageSmall(
                            height: 150,
                            width: 150,
                            url: Usermatch.matches[index].image_0),
                        Text(
                          Usermatch.matches[index].name,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    );
                  },
                  itemCount: Usermatch.matches.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
