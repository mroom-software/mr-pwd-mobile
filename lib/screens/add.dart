import 'package:blockpass/data/models/pwd.dart';
import 'package:blockpass/widgets/input_txt_widget.dart';
import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {

  Pwd pwd;

  AddScreen({Key key, this.pwd}) : super(key: key);

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {

  bool isEditable = false;

  @override
  void initState() {
    if (widget.pwd != null) {
      isEditable = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: .5,
        bottomOpacity: .2,
        title: Text(
          (isEditable) ? 'UPDATE' : 'ADD NEW',
          style: Theme.of(context).textTheme.title,
        ),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            color: Color(0xFFFFFF),
            child: Column(
              children: <Widget>[
                Container(
                  height: 65,
                  color: Colors.white,
                  child: InputTxtWidget(lblLeading: 'Name', lblContent: (widget.pwd != null) ? widget.pwd.name : '', lblPlaceHolder: 'Your bookmark', numLines: 1,),
                ),
                Container(
                  height: 65,
                  color: Colors.white,
                  child: InputTxtWidget(lblLeading: 'Email/Username', lblContent: (widget.pwd != null) ? widget.pwd.email : '', lblPlaceHolder: 'Enter email', numLines: 1,),
                ),
                Container(
                  height: 65,
                  color: Colors.white,
                  child: InputTxtWidget(lblLeading: 'Password', lblContent: (widget.pwd != null) ? widget.pwd.password : '', lblPlaceHolder: '(Required)', numLines: 1),
                ),
                Container(
                  height: 65,
                  color: Colors.white,
                  child: InputTxtWidget(lblLeading: 'URL', lblContent: (widget.pwd != null) ? widget.pwd.url : '', lblPlaceHolder: '(Optional)', numLines: 1),
                ),
                Container(
                  height: 160,
                  color: Colors.white,
                  child: InputTxtWidget(lblLeading: 'Notes', lblContent: (widget.pwd != null) ? widget.pwd.notes : '', lblPlaceHolder: '(Optional)', numLines: 10),
                ),
              ],
            ),

          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            alignment: Alignment.bottomCenter,
            child: FlatButton(
              onPressed: () => Navigator.pop(context, widget.pwd),
              child: Image.asset(
                'assets/check.png'
              ),
            ),

          )
        ],
      ),
    );
  }
}