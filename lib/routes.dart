import 'package:flutter/material.dart';
import 'package:blockpass/screens/login.dart';
import 'package:blockpass/screens/import.dart';

class Routes extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: Color.fromRGBO(255, 238, 238, 1),
        primaryColor: Color.fromRGBO(36, 59, 107, 1),
        primaryColorLight: Color.fromRGBO(106, 123, 138, 1),
        fontFamily: 'Montserrat',
        textTheme: TextTheme(
          title: TextStyle(fontSize: 18.0, fontStyle: FontStyle.normal, color: Color.fromRGBO(36, 59, 107, 1)),
          body1: TextStyle(fontSize: 15.0, fontStyle: FontStyle.normal, color: Color.fromRGBO(36, 59, 107, 1)),
          body2: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700, color: Color.fromRGBO(36, 59, 107, 1)),
          subtitle: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w100, color: Color.fromRGBO(36, 59, 107, 1)),
          display1: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w100, color: Color.fromRGBO(36, 59, 107, 1)),
        ),
      ),
      routes: {
        '/': (context) => LoginScreen(),
        '/import': (context) => ImportScreen(),
      },
    );
  }

}