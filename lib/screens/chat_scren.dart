import 'package:chat_application_yt/screens/group_info_screen.dart';
import 'package:chat_application_yt/service/database%20_service.dart';
import 'package:chat_application_yt/widgets/group_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GroupInfoData {
  final String groupId;
  final String groupName;
  final String adminName;
  const GroupInfoData(this.groupId, this.groupName, this.adminName);
}

class ChatScreen extends StatefulWidget {
  static const routeName = '/chat-scren';
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Stream<QuerySnapshot>? chats;
  String admin = '';

  @override
  void didChangeDependencies() {
    var info = ModalRoute.of(context)!.settings.arguments as GroupData;
    DataBaseService().getChat(info.groupId).then((value) {
      setState(() {
        chats = value;
      });
    });
    DataBaseService().getAdmin(info.groupId).then((value) {
      setState(() {
        admin = value;
      });
    });
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final groupData = ModalRoute.of(context)!.settings.arguments as GroupData;

    return Scaffold(
      appBar: AppBar(
        title: Text(groupData.groupName),
        backgroundColor: Colors.pink,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(GroupInfoScreen.routeName,
                    arguments: GroupInfoData(
                        groupData.groupId, groupData.groupName, admin));
              },
              icon: Icon(Icons.info))
        ],
      ),
    );
  }
}
