import 'dart:convert';

import 'package:blockpass/bc/eos/eos.dart';
import 'package:blockpass/config/app.dart';
import 'package:blockpass/data/db/db.dart';
import 'package:blockpass/data/models/pwd.dart';
import 'package:blockpass/services/user.dart';
import 'package:blockpass/widgets/input_txt_widget.dart';
import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {
  final int selectedIdx;
  AddScreen({Key key, this.selectedIdx = -1}) : super(key: key);

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  Pwd pwd;
  String name, email, password, url, notes;

  @override
  void initState() {
    super.initState();
    loadPwd();
  }

  void loadPwd() async {
    if (widget.selectedIdx > -1) {
      List<Pwd> pwds = await userSrv.getListPwds();
      setState(() {
        pwd = pwds[widget.selectedIdx];
      });
    }
  }

  void btnSaveTouched() async {
    print('$name -- $email -- $password -- $url -- $notes');
    List<Pwd> pwds = await userSrv.getListPwds();

    Pwd data;
    int insertedIndex = widget.selectedIdx;
    if (insertedIndex > -1) {
      pwds.removeAt(insertedIndex);
      data = Pwd(
        name: name ?? pwd.name,
        email: email ?? pwd.email,
        password: password ?? pwd.password,
        url: url ?? pwd.url,
        notes: notes ?? pwd.notes,
      );

    } else {
      insertedIndex = pwds.length;
      data = Pwd(
        name: name,
        email: email,
        password: password,
        url: url,
        notes: notes,
      );
    }

    pwds.insert(insertedIndex, data);
    int syncTime = (DateTime.now().millisecondsSinceEpoch/1000).round();

    // update db
    await userSrv.saveData(pwds);
    app.user.syncTime = syncTime;
    await db.updateUser(app.user);

    // sync to chain
    eos.add(app.eosContracts[app.user.chainID], app.user.name, app.user.data, syncTime);
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
          (pwd != null) ? 'UPDATE' : 'ADD NEW',
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
                  child: InputTxtWidget(lblLeading: 'Name', lblContent: (pwd != null) ? pwd.name ?? '' : '', lblPlaceHolder: 'Your bookmark', callBack: (value) => {
                    name = value
                  },),
                ),
                Container(
                  height: 65,
                  color: Colors.white,
                  child: InputTxtWidget(lblLeading: 'Email/Username', lblContent: (pwd != null) ? pwd.email ?? '' : '', lblPlaceHolder: 'Enter email', callBack: (value) => {
                    email = value
                  },),
                ),
                Container(
                  height: 65,
                  color: Colors.white,
                  child: InputTxtWidget(lblLeading: 'Password', lblContent: (pwd != null) ? pwd.password ?? '' : '', lblPlaceHolder: '(Required)', callBack: (value) => {
                    password = value
                  },),
                ),
                Container(
                  height: 65,
                  color: Colors.white,
                  child: InputTxtWidget(lblLeading: 'URL', lblContent: (pwd != null) ? pwd.url ?? '' : '', lblPlaceHolder: '(Optional)', callBack: (value) => {
                    url = value
                  },),
                ),
                Container(
                  height: 160,
                  color: Colors.white,
                  child: InputTxtWidget(lblLeading: 'Notes', lblContent: (pwd != null) ? pwd.notes ?? '' : '', lblPlaceHolder: '(Optional)', numLines: 10, callBack: (value) => {
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