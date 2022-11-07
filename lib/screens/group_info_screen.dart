import 'package:chat_application_yt/screens/chat_scren.dart';
import 'package:flutter/material.dart';

class GroupInfoScreen extends StatefulWidget {
  static const routeName = 'group-info-page';
  const GroupInfoScreen({super.key});

  @override
  State<GroupInfoScreen> createState() => _GroupInfoScreenState();
}

class _GroupInfoScreenState extends State<GroupInfoScreen> {
  @override
  void initState() {
    getMembers();
    // TODO: implement initState
    super.initState();
  }
  getMembers()async{

  }
  @override
  Widget build(BuildContext context) {
    var groupInfoData =
        ModalRoute.of(context)!.settings.arguments as GroupInfoData;
    return Scaffold(
      appBar: AppBar(title: Text('Group Info')),
      
    );
  }
}
