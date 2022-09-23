import 'package:chat_app/custom_theme_selection.dart';
import 'package:chat_app/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SelectDropDown extends StatefulWidget {
  final Function callback;
  final User user;
  const SelectDropDown(this.user, this.callback, {Key? key}) : super(key: key);

  @override
  _SelectDropDownState createState() => _SelectDropDownState();
}

class _SelectDropDownState extends State<SelectDropDown> {
  List<String> items = ['dark', 'light', 'custom'];
  String currentItem = 'dark';
  void change(dynamic data) {
    setState(() {
      currentItem = data;
      if (data != 'custom') {
        MyThemeData().setTheme(widget.user.uid, data);
        widget.callback();
      } else {
        custom();
      }
    });
  }

  void custom() async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CustomThemeSelection(widget.user)));
    setState(() {});
    widget.callback();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        value: currentItem,
        dropdownColor: MyThemeData.current[0],
        iconEnabledColor: MyThemeData.current[2],
        items: items.map((element) {
          return DropdownMenuItem(
              value: element,
              child: Text(
                element,
                style: TextStyle(color: MyThemeData.current[1]),
              ));
        }).toList(),
        onChanged: change);
  }
}
