import 'package:chat_application_yt/helper/helper_fuctionn.dart';
import 'package:chat_application_yt/screens/search_scren.dart';
import 'package:chat_application_yt/service/auth_service.dart';
import 'package:chat_application_yt/service/database%20_service.dart';
import 'package:chat_application_yt/widgets/group_tile.dart';
import 'package:chat_application_yt/widgets/home_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserData {
  final String userName;
  final String email;

  UserData({required this.userName, required this.email});
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = '/home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

String getId(String res) {
  return res.substring(0, res.indexOf('_'));
}

String getName(String res) {
  return res.substring(res.indexOf('_') + 1);
}

class _HomeScreenState extends State<HomeScreen> {
  Stream? groups;
  String userName = '';
  String email = '';
  bool isProfile = false;
  String groupName = '';
  @override
  void initState() {
    super.initState();
    gettingUserData();
  }

  gettingUserData() async {
    await HelperFuction.getUserName().then((value) {
      setState(() {
        userName = value!;
      });
    });
    await HelperFuction.getUserEmail().then((value) {
      setState(() {
        email = value!;
      });
    });
    await DataBaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserGroup()
        .then((snapshot) {
      setState(() {
        groups = snapshot;
      });
    });
  }

  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomeDrawer(
          userName: userName, email: email, authService: authService),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, SearchScreen.routeName);
              },
              icon: const Icon(Icons.search))
        ],
        backgroundColor: Colors.pink,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Groups',
          style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
        ),
      ),
      body: groupList(),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: Colors.pinkAccent,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          popUpDialog(context);
        },
      ),
    );
  }

  popUpDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            title: const Text(
              'Create A group',
              textAlign: TextAlign.left,
            ),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              TextField(
                onChanged: (value) {
                  setState(() {
                    groupName = value;
                  });
                },
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.pinkAccent),
                        borderRadius: BorderRadius.circular(30)),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.pinkAccent),
                        borderRadius: BorderRadius.circular(30)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.pinkAccent),
                        borderRadius: BorderRadius.circular(30)),
                    errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(30))),
              )
            ]),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel')),
              ElevatedButton(
                onPressed: () {
                  if (groupName != "") {
                    DataBaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                        .createGroup(userName,
                            FirebaseAuth.instance.currentUser!.uid, groupName)
                        .whenComplete(() => Navigator.of(context).pop());
                  }
                },
                child: const Text('Create'),
              )
            ],
          );
        }));
  }

  groupList() {
    return StreamBuilder(
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData) {
          var list = snapshot.data['groups'] as List;
          if (snapshot.data['groups'] != null && list.isNotEmpty) {
            return ListView.builder(
              itemBuilder: (context, index) {
                var revIn = list.length - index - 1;
                return GroupTile(
                    userName: snapshot.data['fullname'],
                    groupId: getId(list[revIn]),
                    groupName: getName(list[revIn]));
              },
              itemCount: list.length,
            );
          } else {
            return empty();
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
      stream: groups,
    );
  }

  empty() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Icon(
              Icons.add_circle,
              color: Colors.grey,
              size: 75,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
                'You have not joined any groups, click on the "+" button to join a group')
          ]),
    );
  }
}
