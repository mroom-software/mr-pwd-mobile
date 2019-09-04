import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static final Utils _singleton = new Utils._internal();
  final storage = new FlutterSecureStorage();

  factory Utils() {
    return _singleton;
  }

  Utils._internal();

  static void showPopup
  (
    BuildContext context, 
    String title, 
    String msg,
    {List<String> buttons: const ['Close'], Future<Function> callback(int index)}
  )
  {
    List<Widget> actions = [];
    buttons.asMap().forEach((index, value) => {
      actions.add(
        new FlatButton(
          child: new Text(value),
          onPressed: () {
            if (callback != null) {
              callback(index);
            }
            Navigator.of(context).pop();
          },
        )
      )
    });
    
    showDialog(
      context: context,
      builder: (BuildContext context) { 
        // return object of type Dialog
        return AlertDialog(
          title: Align(
            alignment: Alignment.center,
            child: Text(
              title,
              style: Theme.of(context).textTheme.title,
            ),
          ),
          content: Container(
            height: 55,
              child: Align(
              alignment: Alignment.center,
              child: Text(
                msg,
                style: Theme.of(context).textTheme.body1,
              ),
            ),
          ),
          actions: actions,
        );
      },
    );
  }

  Future<void> saveSecureData(String key, String value) async {
    storage.write(key: key, value: value);
  }

  Future<String> getSecureData(String key) async {
    return await storage.read(key: key);
  }

  Future<void> deletSecureData(String key) async {
    await storage.delete(key: key);
  }

  final upperCharaters = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];
  final lowerCharaters = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'];
  final numberCharacters = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  final specialCharacters = ['@', '#', '%', '-'];
  String generateStrongPwd() {
    final _random = new Random();
    var upperString = upperCharaters[_random.nextInt(upperCharaters.length)];
    var specialString = specialCharacters[_random.nextInt(specialCharacters.length)] + specialCharacters[_random.nextInt(specialCharacters.length)];
    var lowerString = lowerCharaters[_random.nextInt(lowerCharaters.length)] + lowerCharaters[_random.nextInt(lowerCharaters.length)] + lowerCharaters[_random.nextInt(lowerCharaters.length)];
    var numberString = numberCharacters[_random.nextInt(numberCharacters.length)] + numberCharacters[_random.nextInt(numberCharacters.length)];
    return '$upperString$specialString$lowerString$numberString';
  }

  static String getOsPlatform() {
    return Platform.operatingSystem;
  }

  static void gotoWebsite(BuildContext context, String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Utils.showPopup(context, 'ERROR', 'Could not launch $url');
    }
  }

}

final utils = new Utils();

