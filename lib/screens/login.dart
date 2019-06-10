import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
        color: Color.fromRGBO(253, 238, 238, 1),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Text(
                'LOGIN',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Password',
                          style: TextStyle(
                            color: Color.fromRGBO(36, 59, 107, 1),
                          ),
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
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Your password',
                                      suffixIcon: IconButton(
                                        color: Colors.blueGrey,
                                        icon: Icon(Icons.visibility),
                                        onPressed: () => print('eye clicked'),
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
                              onPressed: () => print('Login pressed'),
                              child: Text(
                                'Login',
                                style: TextStyle(color: Color(0xFFFFFFFF)),
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
                              onPressed: () => print('Import clicked'),
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  'Import new private key',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
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