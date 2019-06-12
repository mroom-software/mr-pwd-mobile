import 'package:blockpass/config/app.dart';
import 'package:flutter/material.dart';

class TextComboWidget extends StatefulWidget {

  final String lblLeading;
  final String lblContent;

  
  TextComboWidget({Key key, this.lblLeading, this.lblContent}) : super(key: key);

  @override
  _TextComboWidgetState createState() => _TextComboWidgetState();
}

class _TextComboWidgetState extends State<TextComboWidget> {
  String _selectedValue;
  List<DropdownMenuItem<String>> _dropDownMenuItems;

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < app.eosNetworks.length; i++) {
      items.add(new DropdownMenuItem(
          value: app.eosNetworks[i],
          child: new Text(app.eosNetworks[i])
      ));
    }
    return items;
  }

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _selectedValue = _dropDownMenuItems[0].value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
              child: Text(
                this.widget.lblLeading,
                style: Theme.of(context).textTheme.display1,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: DropdownButton(
                value: _selectedValue,
                items: _dropDownMenuItems,
                onChanged: changedDropDownItem,
                isExpanded: true,
                style: Theme.of(context).textTheme.body1,
                underline: Container(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void changedDropDownItem(String selectedValue) {
    setState(() {
      _selectedValue = selectedValue;
    });
  }
}