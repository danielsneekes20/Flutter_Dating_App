import 'package:dating_app_ikfram/screens/fullscreenimage_page.dart';
import 'package:flutter/material.dart';
import 'package:dating_app_ikfram/screens/home_page.dart';
import 'package:dating_app_ikfram/screens/persona_page.dart';
import 'package:dating_app_ikfram/screens/login_page.dart';
import 'package:dating_app_ikfram/screens/match_page.dart';
import 'package:dating_app_ikfram/screens/register_page.dart';
import 'package:dating_app_ikfram/components/users.dart';
import 'package:dating_app_ikfram/screens/welkom_page.dart';
import 'package:dating_app_ikfram/screens/start_page.dart';
import 'package:dating_app_ikfram/screens/settings_page.dart';
import 'package:dating_app_ikfram/screens/personal_page.dart';

class RouteGenerator{
  static Route onGenerateRoute(RouteSettings settings) {
    print('The Route is: ${settings.name}');

    switch (settings.name) {
      case '/':
        return HomePage.route();
      case HomePage.routeName:
        return HomePage.route();
      case PersonaPage.routeName:
        return PersonaPage.route(user: settings.arguments as Profile);
      case RegisterPage.routeName:
        return RegisterPage.route();
      case MatchPage.routeName:
        return MatchPage.route();
      case FullscreenImagePage.routeName:
        return FullscreenImagePage.route(images: settings.arguments);
      case WelkomPage.routeName:
        return WelkomPage.route();
      case StartPage.routeName:
        return StartPage.route();
      case SettingsPage.routeName:
        return SettingsPage.route();
      case LoginPage.routeName:
        return LoginPage.route();
      case PersonalPage.routeName:
        return PersonalPage.route();

      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(appBar: AppBar(title: Text('error'))),
      settings: RouteSettings(name: '/error'),
    );
  }
}
