
import 'package:blockpass/services/user.dart';
import 'package:blockpass/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class MnemonicScreen extends StatefulWidget {
  final String privateKey;

  MnemonicScreen({Key key, this.privateKey}) : super(key: key);

  @override
  _MnemonicScreenState createState() => _MnemonicScreenState();
}

class _MnemonicScreenState extends State<MnemonicScreen> {
  bool _loading = false;

  void goMyPwdsScreen(BuildContext context) {
    setState(() {
      _loading = true;
    });
    userSrv.selectChain('Kylin Testnet', widget.privateKey, (result) {
      if (result) {
        Navigator.pushNamedAndRemoveUntil(context, '/', (Route<dynamic> route) => false);
      } else {
        setState(() {
          _loading = false;
        });

        Utils.showPopup(context, 'ERROR', 'Please try again later!');
      }
      
    });
  }

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<ScaffoldState>();
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      key: key,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0.0,
        title: Text(
          'KEEP YOUR PRIVATE KEY!',
          style: Theme.of(context).textTheme.title,
        ),
        leading: Container(),
      ),
      body: ModalProgressHUD(
        opacity: 0,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                child: Text(widget.privateKey),
                onLongPress: () {
                  Clipboard.setData(ClipboardData(text: widget.privateKey));
                  key.currentState.showSnackBar(
                    SnackBar(content: Text("Copied to Clipboard"),));
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Container(
                  height: 60,
                  child: FlatButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () => goMyPwdsScreen(context),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "I've already saved it!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ]),
        ),
        inAsyncCall: _loading,
      ), 
    );
  }
}