import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:blockpass/services/user.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
  bool _loading = false;
  final security = Security();
  final TextEditingController _filter = new TextEditingController();
  String _searchText = '';
  List<Pwd> entries = [];
  List<Pwd> filteredEntries = [];
  Icon _searchIcon = Icon(Icons.search, color: Color.fromRGBO(36, 59, 107, 1),);
  Widget _appBarTitle = Text('LIST', style: TextStyle(fontSize: 18.0, fontStyle: FontStyle.normal, color: Color.fromRGBO(36, 59, 107, 1)),);

  _ListScreenState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredEntries = entries;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    loadEntries();
  }

  void loadEntries() async {
    entries = await userSrv.getListPwds();
    setState(() {
      _loading = true;
      filteredEntries = entries;
    });
    
    eos.myPwds(app.eosContracts[app.user.chainID], app.user.name, callback: (data) => {
      parseData(data as List)
    });
  }

  void parseData(List<Map<String, dynamic>> data) async {
    if (data.length > 0) {
      var row = data.first;
      if (app.user.syncTime == null || row['timestamp'] >= app.user.syncTime) {
        app.user.data = row['data'];
        app.user.syncTime = row['timestamp'] as int;
        app.user.timestamp = row['timestamp'] as int;
        await db.updateUser(app.user);
        
        entries = await userSrv.getListPwds();
      }
    }

    setState(() {
      filteredEntries = entries;
      _loading = false;
    });
  }

  void btnSearchTouched() {
    setState(() {
      if (_searchIcon.icon == Icons.search) {
        _searchIcon = Icon(Icons.close, color: Color.fromRGBO(36, 59, 107, 1),);
        _appBarTitle = TextField(
          style: Theme.of(context).textTheme.body1,
          controller: _filter,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search, color: Color.fromRGBO(36, 59, 107, 1),),
            hintText: 'Search...'
          ),
        );
      } else {
        _searchIcon = Icon(Icons.search, color: Color.fromRGBO(36, 59, 107, 1),);
        _appBarTitle = Text('LIST', style: TextStyle(fontSize: 18.0, fontStyle: FontStyle.normal, color: Color.fromRGBO(36, 59, 107, 1)),);
        filteredEntries = entries;
        _filter.clear();
      }
    });
  }

  void btnLaunchTouched(int index) async {
    String url = filteredEntries[index].url;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Utils.showPopup(context, 'ERROR', 'Could not launch $url');
    }
  }

  void btnDeleteTouched(int index) {
    Pwd pwd = entries[index];
    Utils.showPopup(context, 'WARN', 'Are you sure to wanna delete ${pwd.name}?', buttons: ['OK', 'Cancel'], callback: (idx) async {
      if (idx == 0) {
        entries.removeAt(index);
        int syncTime = (DateTime.now().millisecondsSinceEpoch/1000).round();

        // update db
        await userSrv.saveData(entries);

        // sync
        userSrv.syncJob(syncTime);

        setState(() {
          filteredEntries = entries;
        });
      }
    });
    
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: .5,
        bottomOpacity: .2,
        title: _appBarTitle,
        leading: IconButton(
          onPressed: () => btnSearchTouched(),
          icon: _searchIcon,
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
      );
  }

  Widget _buildList(BuildContext context) {
    if (_searchText.isNotEmpty) {
      List<Pwd> tempList = [];
      for (int i = 0; i < entries.length; i++) {
        Pwd tmp = entries[i];
        if (tmp.name.toLowerCase().contains(_searchText.toLowerCase()) || tmp.email.toLowerCase().contains(_searchText.toLowerCase())) {
          tempList.add(tmp);
        }
      }

      filteredEntries = tempList;
    }

    if (filteredEntries.length == 0) {
      return Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
          child: Column(
            children: <Widget>[
              Image.asset('assets/no_pwds.png'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'No passwords',
                  style: Theme.of(context).textTheme.title,
                ),
              )
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      itemCount: filteredEntries.length,
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
              content: Slidable(
                key: ValueKey(index),
                actionPane: SlidableDrawerActionPane(),
                actions: <Widget>[
                  IconSlideAction(
                    caption: 'Launch',
                    color: Colors.indigo,
                    icon: Icons.launch,
                    onTap: () => btnLaunchTouched(index),
                  ),
                ],
                secondaryActions: <Widget>[
                  IconSlideAction(
                    caption: 'Delete',
                    color: Colors.red,
                    icon: Icons.delete,
                    onTap: () => btnDeleteTouched(index),
                  ),
                ],
                dismissal: SlidableDismissal(
                  child: SlidableDrawerDismissal(),
                ),
                child: PwdRowWidget(pwd: filteredEntries[index],),
              ), 
            ),
            onTap: () => 
              _gotoAddScreen(
              context, 
              AddScreen(
                selectedIdx: index,
              ),
            ),
          );

        } else {
          return GestureDetector(
            child: Slidable(
              key: ValueKey(index),
              actionPane: SlidableDrawerActionPane(),
              actions: <Widget>[
                IconSlideAction(
                  caption: 'Launch',
                  color: Colors.indigo,
                  icon: Icons.launch,
                  onTap: () => btnLaunchTouched(index),
                ),
              ],
              secondaryActions: <Widget>[
                IconSlideAction(
                  caption: 'Delete',
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: () => btnDeleteTouched(index),
                ),
              ],
              dismissal: SlidableDismissal(
                child: SlidableDrawerDismissal(),
              ),
              child: PwdRowWidget(pwd: filteredEntries[index],),
            ),
            onTap: () => _gotoAddScreen(
              context, 
              AddScreen(
                selectedIdx: index,
              ),
            ),
          );
        }
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(color: Color.fromRGBO(108, 123, 138, 0.2)),
    ); 
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: ModalProgressHUD(
        opacity: 0,
        child: Stack(
          children: <Widget>[
            _buildList(context),
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
        inAsyncCall: _loading,
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

      entries = await userSrv.getListPwds();
      setState(() {
        filteredEntries = entries;
      });
    }
  }

}
