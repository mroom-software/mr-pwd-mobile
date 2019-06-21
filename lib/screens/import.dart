import 'package:blockpass/config/app.dart';
import 'package:blockpass/services/user.dart';
import 'package:blockpass/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:blockpass/widgets/combobox_widget.dart';
import 'package:flutter/widgets.dart';

class ImportScreen extends StatefulWidget {

  @override
  _ImportScreenState createState() => _ImportScreenState();
}

class _ImportScreenState extends State<ImportScreen> {
  final privController = TextEditingController(text: '');
  String _selectedChain = 'Mainnet';

  void btnNextClicked() async {

    if (privController.text.isEmpty) {
      Utils.showPopup(context, 'ERROR', 'Your private key is empty!');
      return;  
    }

    userSrv.selectChain(_selectedChain, privController.text, (result) {
      if (!result) {
        Utils.showPopup(context, 'ERROR', 'Please double check your private key!');
        return;  
      }
      Navigator.pushNamedAndRemoveUntil(context, '/', (Route<dynamic> route) => false);

    });

  }

  void createEOSAccount() async {
    Utils.showPopup(context, 'INFO', 'Comming soon!');
  }

  @override
  void dispose() {
    privController.dispose();
    super.dispose();
  }

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
        child:
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Your private key',
                        style: Theme.of(context).textTheme.subtitle,
                      ),
                    ),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 60,
                          color: Colors.white,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child:
                            Container(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: TextField(
                                controller: privController,
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
                  
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Container(
                      height: 60,
                      child: ComboboxWidget(
                        lblLeading: 'EOS',
                        lblContent: _selectedChain,
                        entries: app.eosChains,
                        onChangedChain: (name) => {
                          _selectedChain = name
                        },),
                    ),
                  ),
                    
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      child: RaisedButton(
                        color: Color.fromRGBO(36, 59, 107, 1),
                        onPressed: () => btnNextClicked(),
                        child: Text(
                          'Next',
                          style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16),
                        ),
                      ),
                    ),
                  ),

                  Column(
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
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Text(
                      '-- Or --',
                      style: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                      ),
                    ),
                  ),
                  
                  FlatButton(
                    onPressed: () => createEOSAccount(),
                    child: Text(
                      'Create a free EOS account on Kylin Testnet',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }
}