// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'theme.dart';

class SearchBar extends StatefulWidget {
  final Function(String) callback;
  const SearchBar(this.callback, {Key? key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final controller = TextEditingController();

  void click() {
    widget.callback(controller.text);
    controller.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextField(
        style: TextStyle(color: MyThemeData.current[1]),
        controller: controller,
        decoration: InputDecoration(
            suffixIcon: IconButton(
              color: MyThemeData.current[2],
              icon: Icon(Icons.search),
              onPressed: click,
            ),
            hintStyle: TextStyle(color: MyThemeData.current[1]),
            hintText: 'Enter receiver\'s email.',
            enabled: true,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyThemeData.current[2]))),
      ),
    );
  }
}
