import 'package:blockpass/config/app.dart';
import 'package:flutter/material.dart';
import 'package:blockpass/screens/settings.dart';
import 'package:blockpass/screens/login.dart';
import 'package:blockpass/screens/import.dart';
import 'package:blockpass/screens/list.dart';
import 'package:blockpass/screens/add.dart';
import 'package:blockpass/screens/change_pwd.dart';


class Routes extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Color.fromRGBO(255, 238, 238, 1),
        primaryColor: Color.fromRGBO(36, 59, 107, 1),
        primaryColorLight: Color.fromRGBO(106, 123, 138, 0.8),
        fontFamily: 'Montserrat',
        textTheme: TextTheme(
          title: TextStyle(fontSize: 18.0, fontStyle: FontStyle.normal, color: Color.fromRGBO(36, 59, 107, 1)),
          body1: TextStyle(fontSize: 15.0, fontStyle: FontStyle.normal, color: Color.fromRGBO(36, 59, 107, 1)),
          body2: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700, color: Color.fromRGBO(36, 59, 107, 1)),
          subtitle: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w100, color: Color.fromRGBO(36, 59, 107, 1)),
          display1: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w100, color: Color.fromRGBO(36, 59, 107, 1)),
          display2: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w100, color: Color.fromRGBO(36, 59, 107, 1)),
        ),
      ),
      routes: {
        '/': (context) => (app.user != null) ? LoginScreen() : ImportScreen(),
        '/import': (context) => ImportScreen(),
        '/list': (context) => ListScreen(),
        '/settings': (context) => SettingsScreen(),
        '/add': (context) => AddScreen(),
        '/change_pwd': (context) => ChangePwdScreen(),
      },
    );
  }

}