import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
    {List<String> buttons: const ['Close'], Function callback(int index)}
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

  void test(String key, Function callback) async {
    String k = await storage.read(key: key);
    if (callback != null) {
      callback(k);
    }
  }
}

final utils = new Utils();

