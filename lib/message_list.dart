import 'package:chat_app/message.dart';
import 'package:chat_app/theme.dart';
import 'package:flutter/material.dart';

class MessageList extends StatefulWidget {
  final List<Message> messages;
  const MessageList(this.messages, {Key? key}) : super(key: key);

  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  final controller = ScrollController();

  void scroll() async {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (controller.hasClients) {
        controller.jumpTo(controller.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget listview = ListView.builder(
        controller: controller,
        itemCount: widget.messages.length,
        itemBuilder: (context, index) {
          var message = widget.messages[index];
          return Padding(
              padding: const EdgeInsets.fromLTRB(5, 2.5, 5, 2.5),
              child: Card(
                color: MyThemeData.current[3],
                child: Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text(
                          message.message,
                          style: TextStyle(color: MyThemeData.current[1]),
                        ),
                        subtitle: Row(children: <Widget>[
                          Expanded(
                              child: Text(
                            message.name,
                            style: TextStyle(color: MyThemeData.current[1]),
                          )),
                          Text(
                            message.time,
                            style: TextStyle(color: MyThemeData.current[1]),
                          )
                        ]),
                      ),
                    )
                  ],
                ),
              ));
        });

    scroll();

    return listview;
  }
}
