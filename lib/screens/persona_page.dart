import 'package:dating_app_ikfram/components/models.dart';
import 'package:dating_app_ikfram/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dating_app_ikfram/constants.dart';
import 'package:dating_app_ikfram/screens/home_page.dart';
import 'package:dating_app_ikfram/components/users.dart';

import '../components/appbar.dart';

class PersonaPage extends StatelessWidget {
  static const String routeName = '/persona';

  static Route route({required Profile user}) {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => PersonaPage(
        user: user,
      ),
    );
  }

  final Profile user;
  const PersonaPage({required this.user});

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: Hero(
                tag: 'user_image',
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: NetworkImage(user.image_0),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${user.name}, ${user.age}',
                    style: kProfUi,
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Bio',
                    style: kProfUi.copyWith(fontSize: 25),
                  ),
                  Text(
                    '${user.bio}',
                    style: TextStyle(fontSize: 15, height: 1.3),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Intrests',
                    style: kProfUi.copyWith(fontSize: 25),
                  ),
                  Row(
                    children: user.interests
                        .map(
                          (interest) => Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.only(top: 5, right: 5),
                            decoration: BoxDecoration(
                                color: Color(roze),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(interest),
                          ),
                        )
                        .toList(),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Pictures',
                    style: kProfUi.copyWith(fontSize: 25),
                  ),
                  SizedBox(
                    height: 125,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        List images = [
                          user.image_0,
                          user.image_1,
                          user.image_2,
                          user.image_3,
                          user.image_4
                        ];
                        return GestureDetector(
                          onDoubleTap: () {
                            Navigator.pushNamed(context, '/fullscreen',
                                arguments: images[index]);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Container(
                                height: 125,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        // image:NetworkImage(user.images[index])
                                        image: NetworkImage(images[index])))),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
