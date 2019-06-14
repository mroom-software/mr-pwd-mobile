import 'package:blockpass/widgets/pwd_row_widget.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:blockpass/config/app.dart';
import 'package:flutter/material.dart';

class ListScreen extends StatefulWidget {

  @override
  _ListScreenState createState() => _ListScreenState();

}

class _ListScreenState extends State<ListScreen> {
  List entries = [];

  @override
  void initState() {
    loadEntries();
    super.initState();
  }

  void loadEntries() {
    setState(() {
      entries = ['1', '2'];
    });
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
                  onTap: () => Navigator.pushNamed(context, '/add'),
                );

              } else {
                return GestureDetector(
                  child: PwdRowWidget(),
                  onTap: () => Navigator.pushNamed(context, '/add'),
                );
              }
              
            },
            separatorBuilder: (BuildContext context, int index) => const Divider(color: Color.fromRGBO(108, 123, 138, 0.2)),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: FlatButton(
              onPressed: () => print('add pressed'),
              child: Image.asset('assets/add.png'),
            ),
          ),
        ],
      ), 
    );
  }

}
