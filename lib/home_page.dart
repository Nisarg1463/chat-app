// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:chat_app/chat.dart';
import 'package:chat_app/chat_list.dart';
import 'package:chat_app/database.dart';
import 'package:chat_app/group_register.dart';
import 'package:chat_app/notifications.dart';
import 'package:chat_app/search_bar.dart';
import 'package:chat_app/settings_page.dart';
import 'package:chat_app/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final User user;
  const HomePage(this.user, {Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Chat> chats = [];
  @override
  void initState() {
    super.initState();
    addUser(widget.user);
    userRef(loadUsers);
    initMessaging();
  }

  void getUser(String user) async {
    bool found = await findUser(user);
    if (found) {
      getChatWith(widget.user.email!, user);
    }
  }

  void loadUsers() async {
    await loadNames();
    chats = [];
    await getChats(widget.user.email!, chats, widget.user.uid);
    setState(() {});
  }

  void click() async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => SettingPage(widget.user)));
    setState(() {});
  }

  void createGroup() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => GroupRegister()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyThemeData.current[0],
      appBar: AppBar(
          title: Row(children: [
        Expanded(
            child: Text(
          'My chat app',
        )),
        IconButton(onPressed: createGroup, icon: Icon(Icons.group)),
        IconButton(onPressed: click, icon: Icon(Icons.settings)),
      ])),
      body: Column(
        children: <Widget>[
          SearchBar(getUser),
          Expanded(child: ChatList(chats, widget.user)),
        ],
      ),
    );
  }
}
