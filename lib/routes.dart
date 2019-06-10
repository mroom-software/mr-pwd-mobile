import 'package:flutter/material.dart';
import 'package:blockpass/screens/login.dart';

class Routes extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color.fromRGBO(255, 238, 238, 1),
        fontFamily: 'Montserrat',
      ),
      routes: {
        '/': (context) => LoginScreen(),
      },
    );
  }

}