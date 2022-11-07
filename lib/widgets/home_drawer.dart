import 'package:flutter/material.dart';

import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/profile_screen.dart';
import '../service/auth_service.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    Key? key,
    required this.userName,
    required this.email,
    required this.authService,
  }) : super(key: key);

  final String userName;
  final String email;
  final AuthService authService;

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
          userName,
          style: const TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          height: 2,
        ),
        const ListTile(
          selected: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          selectedColor: Colors.pink,
          leading: Icon(Icons.group),
          title: Text('Groups', style: TextStyle(color: Colors.black)),
        ),
        ListTile(
          onTap: (() {
            Navigator.of(context).pushReplacementNamed(ProfileScreen.routeName,
                arguments: UserData(userName: userName, email: email));
          }),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          selectedColor: Colors.pink,
          leading: const Icon(Icons.account_circle),
          title: const Text('Profile', style: TextStyle(color: Colors.black)),
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
    ));
  }
}
