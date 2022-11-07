import 'package:chat_application_yt/helper/helper_fuctionn.dart';
import 'package:chat_application_yt/screens/chat_scren.dart';
import 'package:chat_application_yt/screens/group_info_screen.dart';
import 'package:chat_application_yt/screens/home_screen.dart';
import 'package:chat_application_yt/screens/login_screen.dart';
import 'package:chat_application_yt/screens/profile_screen.dart';
import 'package:chat_application_yt/screens/search_scren.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSignedIn = false;
  @override
  void initState() {
    super.initState();
    getUserLogedInStatus();
  }

  getUserLogedInStatus() async {
    await HelperFuction.getUserLogedInStatus().then((value) {
      if (value != null) {
        _isSignedIn = value;
      }
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          GroupInfoScreen.routeName: (context) => const GroupInfoScreen(),
          ChatScreen.routeName: (context) => const ChatScreen(),
          ProfileScreen.routeName: (context) => const ProfileScreen(),
          SearchScreen.routeName: (context) => const SearchScreen(),
          LoginScreen.routeName: (context) => const LoginScreen(),
          HomeScreen.routeName: (context) => const HomeScreen(),
        },
        theme: ThemeData(primaryColor: Colors.pink),
        title: 'Flutter Demo',
        home: _isSignedIn ? const HomeScreen() : const LoginScreen());
  }
}
