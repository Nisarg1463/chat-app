import 'package:flutter/material.dart';

class GroupMemberList extends StatefulWidget {
  final List<String>? personList;
  const GroupMemberList(this.personList, {Key? key}) : super(key: key);

  @override
  _GroupMemberListState createState() => _GroupMemberListState();
}

class _GroupMemberListState extends State<GroupMemberList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.personList!.length,
            itemBuilder: (context, index) {
              return Card(
                color: const Color.fromARGB(100, 95, 95, 95),
                child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      widget.personList![index],
                      style: const TextStyle(color: Colors.lightBlue),
                    )),
              );
            }));
  }
}
