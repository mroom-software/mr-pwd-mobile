import 'package:flutter/material.dart';

class PwdRowWidget extends StatefulWidget {

  @override
  _PwdRowWidgetState createState() => _PwdRowWidgetState();
  
}

class _PwdRowWidgetState extends State<PwdRowWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
      color: Color(0xFFFFFF),
      height: 80,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Apple',
                style: Theme.of(context).textTheme.body1,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'wer@mroomsoft.com',
                style: Theme.of(context).textTheme.subtitle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


