// ignore_for_file: prefer_const_constructors

import 'package:chat_app/theme.dart';
import 'package:flutter/material.dart';

class TextInputWidget extends StatefulWidget {
  final Function(String) callback;
  const TextInputWidget(this.callback, {Key? key}) : super(key: key);

  @override
  _TextInputWidgetState createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  final controller = TextEditingController();

  void clicked() {
    setState(() {
      widget.callback(controller.text);
      controller.clear();
      FocusScope.of(context).unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: TextField(
          style: TextStyle(color: MyThemeData.current[1]),
          controller: controller,
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.message,
                color: MyThemeData.current[1],
              ),
              suffixIcon: IconButton(
                icon: Icon(Icons.send),
                onPressed: clicked,
                color: MyThemeData.current[2],
              ),
              hintStyle: TextStyle(color: MyThemeData.current[1]),
              hintText: 'Type your message.',
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyThemeData.current[2]))),
          maxLines: 5,
          minLines: 1,
        ));
  }
}
