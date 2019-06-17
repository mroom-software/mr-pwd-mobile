import 'dart:convert';

import 'package:blockpass/data/db/db.dart';
import 'package:blockpass/utils/security.dart';
import 'package:blockpass/utils/utils.dart';

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
  final security = Security();
  List<Pwd> entries = [];
  

  @override
  void initState() {
    super.initState();
    loadEntries();
  }

  void loadEntries() async {
    var cachedEntries = await app.user.getListPwds();
    if (cachedEntries.length > 0) {
      setState(() {
        entries = cachedEntries;
      });
    }
    eos.myPwds(app.eosContracts[app.user.chainID], app.user.name, callback: (data) => {
      parseData(data as List)
    });
  }

  void parseData(List<Map<String, dynamic>> data) {
    if (data.length > 0) {
      var row = data.first;
      if (app.user.syncTime == null || row['timestamp'] >= app.user.syncTime) {
        app.user.data = row['data'];
        app.user.syncTime = row['timestamp'] as int;
        db.updateUser(app.user);
        setState(() {
          List<dynamic> lst = json.decode(row['data']); 
          entries.clear();
          for (int i = 0; i < lst.length; i++) {
            Pwd pwd = Pwd.fromJson(jsonDecode(lst[0]));
            entries.add(pwd);
          }
        });
      }
    }
  }

  void btnSearchTouched() async {
    var cachedData = await app.user.getListPwds();
    setState(() {
      entries = cachedData;
    });
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
                      color: Colors.grey.shade100,
                      padding: new EdgeInsets.symmetric(horizontal: 15.0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'ALL',
                        style: Theme.of(context).textTheme.body1,
                      ),
                    ),
                    content: PwdRowWidget(pwd: entries[index],),
                  ),
                  onTap: () => 
                    Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context) => AddScreen(pwd: entries[index],
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
              onPressed: () => _gotoAddScreen(context, AddScreen()),
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
      Utils.showPopup(context, 'INFO', '${data.name} saved successfully!');
    }
  }

}
