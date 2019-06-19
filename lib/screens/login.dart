import 'package:blockpass/bc/eos/eos.dart';
import 'package:blockpass/config/app.dart';
import 'package:blockpass/data/db/db.dart';
import 'package:blockpass/utils/utils.dart';
import 'package:flutter/material.dart';
import 'dart:convert';


class LoginScreen extends StatefulWidget {
  
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final txtPwdController = TextEditingController();
  bool showPwd = false;
  bool isNeedToInputPwdToLogin = false;


  @override
  void initState() {
    showPwd = false;
    reloadUser();
    super.initState();
  }

  @override
  void dispose() {
    txtPwdController.dispose();
    super.dispose();
  }

  Future<void> reloadUser() async {
    app.user = await db.selectUser();  
    setState(() {
      isNeedToInputPwdToLogin = (app.user != null) ? true : false;
    });
    
  }

  void showPwdChanged() {
    setState(() {
      showPwd = !showPwd;
    });
  }

  void btnDoneTouched() async {
    var str = txtPwdController.text.trim();
    var bytes = utf8.encode(str);
    var pwd = base64.encode(bytes);

    if (pwd.length == 0) {
      Utils.showPopup(context, 'Error', 'Password invalid!');
      return;
    }

    if (app.user != null) {
      if (app.user.password.length == 0) {
        app.user.password = pwd;
        db.updateUser(app.user);
      } else {
        if (pwd != app.user.password) {
          Utils.showPopup(context, 'Error', 'Wrong password!');
          return;
        } 
      }
    } else {
      Utils.showPopup(context, 'Error', 'user is null!');
      return;
    }

    // init eos
    var privKey = await utils.getSecureData('priKey');
    bool value = eos.connect(app.eosChainURL[app.user.chainID], privKey);

    if (value) {
      Navigator.pushNamedAndRemoveUntil(context, '/list', (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {    
    if (isNeedToInputPwdToLogin) {
      return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          elevation: 0.0,
          title: Text(
            'LOGIN',
            style: Theme.of(context).textTheme.title,
          ),
        ),
        body: Stack(
          children: <Widget>[
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 120),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Type your password',
                          style: Theme.of(context).textTheme.subtitle,
                        ),
                      ),
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Container(
                        height: 60,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: TextField(
                              controller: txtPwdController,
                              obscureText: showPwd ? false : true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Your password',
                                suffixIcon: IconButton(
                                  color: Colors.blueGrey,
                                  icon: showPwd ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                                  onPressed: () => showPwdChanged(),
                                ),
                              ),
                            ),
                          ),
                        ), 
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        child: RaisedButton(
                          color: Color.fromRGBO(36, 59, 107, 1),
                          onPressed: () => btnDoneTouched(),
                          child: Text(
                            'Done',
                            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              alignment: Alignment.bottomCenter,
              child: FlatButton(
                onPressed: () => print('1'),
                child: Image.asset(
                  'assets/touch_id.png'
                ),
              ),

            ),
          ],
        ),
      );

    } else {
      return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          elevation: 0.0,
          title: Text(
            'LOGIN',
            style: Theme.of(context).textTheme.title,
          ),
        ),
        body: Stack(
          children: <Widget>[
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Password',
                          style: Theme.of(context).textTheme.subtitle,
                        ),
                      ), 
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Container(
                        height: 60,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: TextField(
                              controller: txtPwdController,
                              obscureText: showPwd ? false : true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Your password',
                                suffixIcon: IconButton(
                                  color: Colors.blueGrey,
                                  icon: showPwd ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                                  onPressed: () => showPwdChanged(),
                                ),
                              ),
                            ),
                          ),
                        ), 
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        child: RaisedButton(
                          color: Color.fromRGBO(36, 59, 107, 1),
                          onPressed: () => btnDoneTouched(),
                          child: Text(
                            'Login',
                            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Container(  
                        height: 40,
                        child: FlatButton(
                          onPressed: () => Navigator.pushNamed(context, '/import'),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              'Import new private key',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              alignment: Alignment.bottomCenter,
              child: FlatButton(
                onPressed: () => print('1'),
                child: Image.asset(
                  'assets/touch_id.png'
                ),
              ),

            ),
          ],
        ),
      );
    }
  }
}