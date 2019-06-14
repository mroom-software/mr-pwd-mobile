import 'package:sticky_headers/sticky_headers.dart';
import 'package:blockpass/config/app.dart';
import 'package:flutter/material.dart';

class ListScreen extends StatefulWidget {

  @override
  _ListScreenState createState() => _ListScreenState();

}

class _ListScreenState extends State<ListScreen> {

  List entries = ['1', '1', '1'];

  @override
  void initState() {
    print(app.user.toString());
    super.initState();
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
      body: ListView.separated(
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Container(
              color: Color.fromRGBO(255, 255, 255, 0),
              padding: const EdgeInsets.all(10.0),
              height: 80,
              child: Text(
                'Entry ${entries[index]}',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              alignment: Alignment(-1, 0),
            ),
            onTap: () => Navigator.pushNamed(context, '/add'),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(color: Color.fromRGBO(108, 123, 138, 0.2)),
      ),
    );
  }
}
