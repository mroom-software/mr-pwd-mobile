import 'package:flutter/material.dart';
import 'package:blockpass/widgets/text_combo_widget.dart';

class ImportScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0.0,
        title: Text(
          'IMPORT',
          style: Theme.of(context).textTheme.title,
        ),
        leading: Container(),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 8,
              child: Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Text(
                            'Your private key',
                            style: Theme.of(context).textTheme.display1,
                          ),
                        ),
                      )
                    ),
                    Expanded(
                      flex: 1, 
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                                      hintText: '',
                                    ),
                                  ),
                                ),
                              )
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                          children: <Widget>[
                            Container(
                              height: 60,
                              child: TextComboWidget(lblLeading: 'EOS', lblContent: 'Mainnet'),
                            )
                          ],
                        ), 
                    ),
                    Expanded(
                      flex: 1, 
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            child: RaisedButton(
                              color: Color.fromRGBO(36, 59, 107, 1),
                              onPressed: () => print('Login clicked'),
                              child: Text(
                                'Next',
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
                              onPressed: () => Navigator.pop(context),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Already have an account? Login here',
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
                    Expanded(
                      flex: 1,
                      child: FlatButton(
                        onPressed: () => print('Skip touched'),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            'Skip',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }

}