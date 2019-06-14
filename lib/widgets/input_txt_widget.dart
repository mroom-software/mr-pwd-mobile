import 'package:flutter/material.dart';

class InputTxtWidget extends StatefulWidget {

  String lblLeading;
  String lblContent;

  InputTxtWidget({Key key, this.lblLeading, this.lblContent}) : super(key: key);

  @override
  _InputTxtWidgetState createState() => _InputTxtWidgetState();
}

class _InputTxtWidgetState extends State<InputTxtWidget> {

  TextEditingController txtController = TextEditingController();
  
  @override
  void initState() {
    txtController.text = widget.lblContent;
    super.initState();
  }

  @override
  void dispose() {
    txtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFFFFF),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 9,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: Text(
                      this.widget.lblLeading,
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: TextField(
                      controller: txtController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Your bookmark',
                      ),
                      style: Theme.of(context).textTheme.body1,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 1,
                color: Color.fromRGBO(108, 123, 138, 0.2),
              ),
            ),
          ),
        ],
      ), 
    );
  }

}