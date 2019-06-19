import 'package:flutter/material.dart';

class InputTxtWidget extends StatelessWidget {
  final TextEditingController txtController = TextEditingController();
  final String lblLeading;
  final String lblContent;
  final String lblPlaceHolder;
  final int numLines;
  final Function callBack;

  InputTxtWidget({Key key, this.lblLeading, this.lblContent, this.lblPlaceHolder = '', this.numLines = 1, this.callBack, }) : super(key: key) {
    txtController.text = lblContent;
    txtController.addListener(_responseValue);
  }

  void _responseValue() {
    if (this.callBack != null) {
      this.callBack(txtController.text);
    }
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
                      this.lblLeading,
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: TextField(
                      keyboardType: (this.numLines > 1) ? TextInputType.multiline : TextInputType.text,
                      maxLines: this.numLines,
                      controller: txtController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: this.lblPlaceHolder,
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