import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Utils {
  static final Utils _singleton = new Utils._internal();
  final storage = new FlutterSecureStorage();

  factory Utils() {
    return _singleton;
  }

  Utils._internal();

  static void showPopup(BuildContext context, String title, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) { 
        // return object of type Dialog
        return AlertDialog(
          title: Align(
            alignment: Alignment.center,
            child: Text(title),
          ),
          content: Container(
            height: 40,
              child: Align(
              alignment: Alignment.center,
              child: Text(msg),
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
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
}

final utils = new Utils();

