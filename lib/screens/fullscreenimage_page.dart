import 'package:flutter/material.dart';

import '../components/appbar.dart';

class FullscreenImagePage extends StatelessWidget {
  static const String routeName = '/fullscreen';

  static Route route({required images}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => FullscreenImagePage(images: images),
    );
  }

  final images;
  FullscreenImagePage({required this.images});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Couply',button: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(images),
          )
        ),
      ),
    );
  }
}


