import 'package:flutter/material.dart';

class TextComboWidget extends StatefulWidget {

  final String lblLeading;
  final String lblContent;

  
  TextComboWidget({Key key, this.lblLeading, this.lblContent}) : super(key: key);

  @override
  _TextComboWidgetState createState() => _TextComboWidgetState();
}

class _TextComboWidgetState extends State<TextComboWidget> {
  List _cities = ["Mainnet", "Kylin Testnet", "Jungle Testnet"];
  List<DropdownMenuItem<String>> _dropDownMenuItems;

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in _cities) {
      items.add(new DropdownMenuItem(
          value: city,
          child: new Text(city)
      ));
    }
    return items;
  }

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
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
                value: 'Mainnet',
                items: _dropDownMenuItems,
                onChanged: (selectedItem) => print(selectedItem),
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
}