import 'package:chat_application_yt/screens/chat_scren.dart';
import 'package:flutter/material.dart';

class GroupData {
  final String groupName;
  final String groupId;
  final String userName;
  GroupData(
      {required this.groupId, required this.groupName, required this.userName});
}

class GroupTile extends StatefulWidget {
  final String userName;
  final String groupId;
  final String groupName;
  const GroupTile(
      {super.key,
      required this.userName,
      required this.groupId,
      required this.groupName});

  @override
  State<GroupTile> createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        Navigator.of(context).pushNamed(ChatScreen.routeName,
            arguments: GroupData(
                groupId: widget.groupId,
                groupName: widget.groupName,
                userName: widget.userName));
      }),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.pinkAccent,
            radius: 30,
            child: Text(
              widget.groupName.substring(0, 1).toUpperCase(),
              style: TextStyle(color: Colors.white),
            ),
          ),
          title: Text(
            widget.groupName,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            'Join the conversation as ${widget.userName}',
            style: TextStyle(fontSize: 11),
          ),
        ),
      ),
    );
  }
}
