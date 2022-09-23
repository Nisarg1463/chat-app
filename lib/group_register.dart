// ignore_for_file: prefer_const_constructors

import 'package:chat_app/database.dart';
import 'package:chat_app/group_member_list.dart';
import 'package:chat_app/theme.dart';
import 'package:flutter/material.dart';

class GroupRegister extends StatefulWidget {
  const GroupRegister({Key? key}) : super(key: key);

  @override
  _GroupRegisterState createState() => _GroupRegisterState();
}

class _GroupRegisterState extends State<GroupRegister> {
  var name = TextEditingController();
  List<String> personList = [];
  var member = TextEditingController();
  void add() {
    setState(() {
      personList.add(member.text);
      member.clear();
    });
  }

  void remove() {
    setState(() {
      personList.removeLast();
    });
  }

  void register() {
    createGroupChat(personList, name.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text(
            'Register your group.',
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Name of your group: ',
                      style: TextStyle(color: MyThemeData.current[2]),
                    ),
                    Expanded(
                        child: TextField(
                      controller: name,
                      style: TextStyle(
                        color: MyThemeData.current[1],
                      ),
                      decoration: InputDecoration(
                          hintText: 'Friends',
                          hintStyle: TextStyle(color: MyThemeData.current[1]),
                          enabled: true,
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: MyThemeData.current[2]))),
                    ))
                  ],
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                    child: Row(children: [
                      Text(
                        'Entered members : ',
                        style: TextStyle(color: MyThemeData.current[2]),
                      ),
                      GroupMemberList(personList)
                    ])),
                Padding(
                    padding: EdgeInsets.fromLTRB(130, 10, 0, 10),
                    child: TextField(
                      controller: member,
                      style: TextStyle(color: MyThemeData.current[1]),
                      decoration: InputDecoration(
                          hintText: 'xyz123@gmail.com',
                          hintStyle: TextStyle(color: MyThemeData.current[1]),
                          enabled: true,
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: MyThemeData.current[2]))),
                    )),
                Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: register,
                              child: Text(
                                'Create',
                                style: TextStyle(color: MyThemeData.current[2]),
                              )),
                          IconButton(
                            onPressed: add,
                            icon: const Icon(Icons.person_add),
                            color: MyThemeData.current[2],
                          ),
                          IconButton(
                            onPressed: remove,
                            icon: const Icon(Icons.person_remove),
                            color: MyThemeData.current[2],
                          )
                        ]))
              ],
            ),
          ),
        ));
  }
}
