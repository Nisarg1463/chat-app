import 'package:chat_app/chat.dart';
import 'package:chat_app/chat_page.dart';
import 'package:chat_app/database.dart';
import 'package:chat_app/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatList extends StatefulWidget {
  final List<Chat> chats;
  final User user;
  const ChatList(this.chats, this.user, {Key? key}) : super(key: key);

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  void click(Chat chat) async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => ChatPage(chat, widget.user)));
    setActive(chat.id, widget.user.uid, false);
  }

  @override
  Widget build(BuildContext context) {
    Widget listview = ListView.builder(
        itemCount: widget.chats.length,
        itemBuilder: (context, index) {
          var chat = widget.chats[index];
          return Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Card(
                color: MyThemeData.current[3],
                child: Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: TextButton(
                          child: Row(children: [
                            Expanded(
                                child: Text(
                              chat.name,
                              style: TextStyle(color: MyThemeData.current[1]),
                            )),
                            Text('${chat.pending}',
                                style: TextStyle(
                                  color: MyThemeData.current[1],
                                ))
                          ]),
                          onPressed: () => {click(chat)},
                        ),
                      ),
                    )
                  ],
                ),
              ));
        });
    return listview;
  }
}
