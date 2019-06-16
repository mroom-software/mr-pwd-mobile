import 'package:blockpass/utils/utils.dart';
import 'package:flutter_string_encryption/flutter_string_encryption.dart';
import 'package:blockpass/bc/eos/eos.dart';
import 'package:blockpass/data/models/pwd.dart';
import 'package:blockpass/screens/add.dart';
import 'package:blockpass/widgets/pwd_row_widget.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:blockpass/config/app.dart';
import 'package:flutter/material.dart';

class ListScreen extends StatefulWidget {

  @override
  _ListScreenState createState() => _ListScreenState();

}

class _ListScreenState extends State<ListScreen> {
  final cryptor = new PlatformStringCryptor();
  List entries = [];
  

  @override
  void initState() {
    loadEntries();
    super.initState();
  }

  void loadEntries() async {
    if (app.user.data != null && app.user.data.length > 0) {
      try {
        final String decrypted = await cryptor.decrypt(app.user.data, await utils.getSecureData('priKey'));
        print(decrypted); // - A string to encrypt.
      } on MacMismatchException {
        // unable to decrypt (wrong key or forged data)
      }
    }
    eos.myPwds('trongdth1234', app.user.name);
  }

  void btnSearchTouched() {

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
          'LIST',
          style: Theme.of(context).textTheme.title,
        ),
        leading: IconButton(
          onPressed: () => btnSearchTouched(),
          icon: Icon(
            Icons.search,
            color: Theme.of(context).primaryColor,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed('/settings'),
            icon: Icon(
              Icons.settings,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          ListView.separated(
            itemCount: entries.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return GestureDetector(
                  child: new StickyHeader(
                    header: new Container(
                      height: 40.0,
                      color: Colors.white,
                      padding: new EdgeInsets.symmetric(horizontal: 15.0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'ALL',
                        style: Theme.of(context).textTheme.body1,
                      ),
                    ),
                    content: PwdRowWidget(),
                  ),
                  onTap: () => 
                    Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context) => AddScreen(pwd: Pwd(name: 'Gmail', email: 'wer@mroomsoft.com', password: '123456', url: 'gmail.com', notes: 'Nothing to say'),
                      ),
                    )).then((value) {
                      print(value);
                    }),
                );

              } else {
                return GestureDetector(
                  child: PwdRowWidget(),
                  onTap: () => _gotoAddScreen(
                    context, 
                    AddScreen(
                      pwd: Pwd (
                        name: 'Gmail', 
                        email: 'wer@mroomsoft.com', 
                        password: '123456', 
                        url: 'gmail.com', 
                        notes: 'Nothing to say'
                      ),
                    ),
                  ),
                );
              }
            },
            separatorBuilder: (BuildContext context, int index) => const Divider(color: Color.fromRGBO(108, 123, 138, 0.2)),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: FlatButton(
              onPressed: () => Navigator.pushNamed(context, '/add'),
              child: Image.asset('assets/add.png'),
            ),
          ),
        ],
      ), 
    );
  }

  _gotoAddScreen(BuildContext context, Widget page) async {  
    final data = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    ) as Pwd;

    if (data != null) {
      print(data.toString());
    }
  }

}
