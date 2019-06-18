import 'package:flutter/material.dart';

class ComboboxWidget extends StatefulWidget {

  final String lblLeading;
  final String lblContent;
  final List entries;
  final Function(String) onChangedChain;

  ComboboxWidget({Key key, this.lblLeading, this.lblContent, this.entries, this.onChangedChain}) : super(key: key);

  @override
  _ComboboxWidgetState createState() => _ComboboxWidgetState();
}

class _ComboboxWidgetState extends State<ComboboxWidget> {
  String _selectedValue = '';
  List<DropdownMenuItem<String>> _dropDownMenuItems;

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < widget.entries.length; i++) {
      if (widget.entries[i] == widget.lblContent) {
        _selectedValue = widget.entries[i];
      }
      items.add(new DropdownMenuItem(
          value: widget.entries[i],
          child: new Text(widget.entries[i])
      ));
    }

    if (_selectedValue.isEmpty) {
      _selectedValue = items[0].value;
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
      if (widget.onChangedChain != null) {
        widget.onChangedChain(_selectedValue);
      }
    });
  }
}