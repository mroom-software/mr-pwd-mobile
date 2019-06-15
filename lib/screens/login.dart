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
  bool showPwd;

  bool isNeedToInputPwdToLogin() {
    if (app.user != null) {
      return true;
    } 
    return false;
  }

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
  }

  void showPwdChanged() {
    setState(() {
      showPwd = !showPwd;
    });
  }

  void btnDoneTouched() async {
    var str = txtPwdController.text;
    var bytes = utf8.encode(str);
    var pwd = base64.encode(bytes);

    if (pwd.trim().length == 0) {
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
    if (isNeedToInputPwdToLogin()) {
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
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 6,
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Password',
                            style: Theme.of(context).textTheme.subtitle,
                          ),
                        )
                      ),
                      Expanded(
                        flex: 1, 
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 60,
                                color: Colors.white,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child:
                                  Container(
                                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
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
                                )
                              ),
                            ],
                          ),
                        )
                      ),
                      Expanded(
                        flex: 3, 
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.center,
                  child: FlatButton(
                    onPressed: () => print('Touch ID pressed'),
                    child: Image.asset('assets/touch_id.png'),
                  ),
                )
              ),
            ],
          ),
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
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 6,
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Password',
                            style: Theme.of(context).textTheme.subtitle,
                          ),
                        )
                      ),
                      Expanded(
                        flex: 1, 
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 60,
                                color: Colors.white,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child:
                                  Container(
                                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
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
                                )
                              ),
                            ],
                          ),
                        )
                      ),
                      Expanded(
                        flex: 1, 
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
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
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: <Widget>[
                            Container(  
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
                            )
                          ],
                        )
                      ),
                    ],
                  ),
                ),
                
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.center,
                  child: FlatButton(
                    onPressed: () => print('Touch ID pressed'),
                    child: Image.asset('assets/touch_id.png'),
                  ),
                )
              ),
            ],
          ),
        ),
      );
    }
  }
}