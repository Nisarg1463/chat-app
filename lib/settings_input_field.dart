// ignore_for_file: prefer_const_constructors

import 'package:chat_app/database.dart';
import 'package:chat_app/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsInputWidget extends StatefulWidget {
  final User user;
  const SettingsInputWidget(this.user, {Key? key}) : super(key: key);

  @override
  _SettingsInputWidgetState createState() => _SettingsInputWidgetState();
}

class _SettingsInputWidgetState extends State<SettingsInputWidget> {
  final controller = TextEditingController();

  void click() async {
    if (controller.text != '') {
      setState(() {
        widget.user.updateDisplayName(controller.text);
        changeUIDname(widget.user.email!, controller.text);
        controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: MyThemeData.current[1]),
      controller: controller,
      decoration: InputDecoration(
          hintStyle: TextStyle(color: MyThemeData.current[1]),
          hintText: 'Enter new name',
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyThemeData.current[2])),
          suffixIcon: IconButton(
              onPressed: click,
              icon: Icon(
                Icons.check,
                color: MyThemeData.current[2],
              ))),
    );
  }
}
