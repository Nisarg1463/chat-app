// ignore_for_file: prefer_const_constructors

import 'package:chat_app/chat.dart';
import 'package:chat_app/database.dart';
import 'package:chat_app/notifications.dart';
import 'package:chat_app/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'message.dart';
import 'message_list.dart';
import 'text_input_widget.dart';

class ChatPage extends StatefulWidget {
  final Chat chat;
  final User user;
  const ChatPage(this.chat, this.user, {Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Message> messages = [];

  @override
  void initState() {
    super.initState();
    load();
    chatRef(widget.chat.id, refresh);
    activateChat();
  }

  void activateChat() async {
    await setActive(widget.chat.id, widget.user.uid, true);
    removeUnread(widget.chat.id, widget.user.uid);
  }

  void refresh() {
    if (mounted) {
      setState(() {
        load();
      });
    }
  }

  void load() async {
    var op = await getMessages(widget.chat.id);
    if (op != null) {
      setState(() {
        messages = op;
      });
    }
  }

  void addMessage(String text) {
    setState(() {
      Message message = Message();
      message.create(widget.user.displayName!, text);
      messages.add(message);
      updateChat(widget.chat.id, message);
      sendNotification(
          widget.chat.users,
          'New message from ${widget.user.displayName!}',
          message.message,
          widget.chat.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyThemeData.current[0],
      appBar: AppBar(title: Text(widget.chat.name)),
      body: Column(
        children: <Widget>[
          Expanded(child: MessageList(messages)),
          TextInputWidget(addMessage),
        ],
      ),
    );
  }
}
