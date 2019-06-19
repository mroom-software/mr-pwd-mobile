import 'dart:convert';

import 'package:blockpass/bc/eos/eos.dart';
import 'package:blockpass/config/app.dart';
import 'package:blockpass/data/db/db.dart';
import 'package:blockpass/data/models/pwd.dart';
import 'package:blockpass/widgets/input_txt_widget.dart';
import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {

  final Pwd pwd;
  AddScreen({Key key, this.pwd}) : super(key: key);

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {

  bool isEditable = false;
  String name, email, password, url, notes;

  @override
  void initState() {
    if (widget.pwd != null) {
      isEditable = true;
    }
    super.initState();
  }

  void btnSaveTouched() async {
    print('$name -- $email -- $password -- $url -- $notes');
    List<Pwd> pwds = await app.user.getListPwds();
    Pwd data;
    if (this.isEditable) {
      pwds.removeAt(widget.pwd.index);
      data = Pwd(
        index: widget.pwd.index,
        name: name ?? widget.pwd.name,
        email: email ?? widget.pwd.email,
        password: password ?? widget.pwd.password,
        url: url ?? widget.pwd.url,
        notes: notes ?? widget.pwd.notes,
      );

    } else {
      data = Pwd(
        index: pwds.length,
        name: name,
        email: email,
        password: password,
        url: url,
        notes: notes,
      );
    }

    pwds.insert(data.index, data);
    int syncTime = (DateTime.now().millisecondsSinceEpoch/1000).round();

    // update db
    app.user.data = jsonEncode(pwds);
    app.user.syncTime = syncTime;
    db.updateUser(app.user);

    // sync to chain
    eos.add(app.eosContracts[app.user.chainID], app.user.name, jsonEncode(pwds), syncTime);
    Navigator.pop(context, data);
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
                  child: InputTxtWidget(lblLeading: 'Name', lblContent: (isEditable) ? widget.pwd.name ?? '' : '', lblPlaceHolder: 'Your bookmark', callBack: (value) => {
                    name = value
                  },),
                ),
                Container(
                  height: 65,
                  color: Colors.white,
                  child: InputTxtWidget(lblLeading: 'Email/Username', lblContent: (isEditable) ? widget.pwd.email ?? '' : '', lblPlaceHolder: 'Enter email', callBack: (value) => {
                    email = value
                  },),
                ),
                Container(
                  height: 65,
                  color: Colors.white,
                  child: InputTxtWidget(lblLeading: 'Password', lblContent: (isEditable) ? widget.pwd.password ?? '' : '', lblPlaceHolder: '(Required)', callBack: (value) => {
                    password = value
                  },),
                ),
                Container(
                  height: 65,
                  color: Colors.white,
                  child: InputTxtWidget(lblLeading: 'URL', lblContent: (isEditable) ? widget.pwd.url ?? '' : '', lblPlaceHolder: '(Optional)', callBack: (value) => {
                    url = value
                  },),
                ),
                Container(
                  height: 160,
                  color: Colors.white,
                  child: InputTxtWidget(lblLeading: 'Notes', lblContent: (isEditable) ? widget.pwd.notes ?? '' : '', lblPlaceHolder: '(Optional)', numLines: 10, callBack: (value) => {
                    notes = value
                  },),
                ),
              ],
            ),

          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            alignment: Alignment.bottomCenter,
            child: FlatButton(
              onPressed: () => btnSaveTouched(),
              child: Image.asset(
                'assets/check.png'
              ),
            ),

          ),
        ],
      ),
    );
  }
}