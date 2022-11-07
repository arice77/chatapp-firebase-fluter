import 'package:chat_application_yt/service/auth_service.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile-screen';
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var authService = AuthService();
  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)!.settings.arguments as UserData;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
              color: Colors.white, fontSize: 27, fontWeight: FontWeight.bold),
        ),
      ),
      drawer: Drawer(
          child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 50),
        children: [
          const Icon(
            Icons.account_circle,
            size: 150,
            color: Colors.grey,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            data.userName,
            style: const TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            height: 2,
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            },
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            selectedColor: Colors.pink,
            leading: const Icon(Icons.group),
            title: const Text('Groups', style: TextStyle(color: Colors.black)),
          ),
          const ListTile(
            selected: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            selectedColor: Colors.pink,
            leading: Icon(Icons.account_circle),
            title: Text('Profile', style: TextStyle(color: Colors.black)),
          ),
          ListTile(
            onTap: () async {
              await authService.signOut(context).then((value) =>
                  Navigator.of(context)
                      .pushReplacementNamed(LoginScreen.routeName));
            },
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            selectedColor: Colors.pink,
            leading: const Icon(Icons.exit_to_app),
            title: const Text('LogOut', style: TextStyle(color: Colors.black)),
          ),
        ],
      )),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 170),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.account_circle,
                  color: Colors.grey,
                  size: 200,
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Full Name',
                      style: TextStyle(fontSize: 17),
                    ),
                    Text(
                      data.userName,
                      style: const TextStyle(fontSize: 17),
                    ),
                  ],
                ),
                const Divider(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Email',
                      style: TextStyle(fontSize: 17),
                    ),
                    Text(
                      data.email,
                      style: const TextStyle(fontSize: 17),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
