// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:chat_app/auth.dart';
import 'package:chat_app/database.dart';
import 'package:chat_app/settings_input_field.dart';
import 'package:chat_app/theme.dart';
import 'package:chat_app/theme_select_dropdown.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingPage extends StatefulWidget {
  final User user;
  const SettingPage(this.user, {Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  void click() async {
    await removePid(widget.user.uid);
    signOutGoogle();
    await SystemNavigator.pop();
  }

  void update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyThemeData.current[0],
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Align(
                alignment: Alignment.center,
                child: Column(children: [
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Text(
                        'Enter new name: ',
                        style: TextStyle(
                            fontSize: 20, color: MyThemeData.current[1]),
                      )),
                      Expanded(
                        child: SettingsInputWidget(widget.user),
                      )
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(75, 10, 0, 10),
                      child: Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                              child: Text(
                                'Theme : ',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: MyThemeData.current[1]),
                              )),
                          SelectDropDown(widget.user, update),
                        ],
                      )),
                  TextButton(
                    child: Text(
                      'Sign Out',
                      style: TextStyle(color: MyThemeData.current[2]),
                    ),
                    onPressed: () => click(),
                  ),
                ]))));
  }
}
