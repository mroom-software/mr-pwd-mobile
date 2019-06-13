import 'package:flutter/material.dart';

class Utils {

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
            height: 50,
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

}

