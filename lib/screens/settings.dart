import 'package:blockpass/config/app.dart';
import 'package:blockpass/widgets/combobox_widget.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';

class SettingsScreen extends StatefulWidget {

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  List<dynamic> entries = [
    ComboboxWidget(
      lblLeading: 'Network',
      lblContent: app.user.network,
      entries: ['EOS'],
    ),

    ComboboxWidget(
      lblLeading: 'Chain',
      lblContent: app.user.chainID,
      entries: app.eosChains
    ),

    GestureDetector(
      child: Container(
        color: Color(0xFFFFFF),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Change Password',
          ),
        ),
      ), 
      onTap: () => print('Change pwd touched'),
    ),

    GestureDetector(
      child: Container(
        color: Color(0xFFFFFF),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Sync Now',
          ),
        ),
      ),
      onTap: () => print('Sync now touched'),
    ),

    GestureDetector (
      child: Container(
        color: Color(0xFFFFFF),
        padding: const EdgeInsets.fromLTRB(0, 10, 20, 0),
        height: 50,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            'Sign out',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ),
      onTap: () => print('Sign out touched'),
    ),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: .5,
        bottomOpacity: .2,
        title: Text(
          'SETTINGS',
          style: Theme.of(context).textTheme.title,
        ),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: ListView.separated(
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return StickyHeader(
              header: Container(
                height: 45.0,
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  'CONFIGS',
                  style: Theme.of(context).textTheme.body1,
                ),
              ),
              content: Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: entries[index],
              ),
            );

          } else {
            return Container(
              height: 60,
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: entries[index],
            );
          }
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(color: Color.fromRGBO(108, 123, 138, 0.2)),
      ),
    );
  }
}