import 'package:chat_application_yt/helper/helper_fuctionn.dart';
import 'package:chat_application_yt/screens/home_screen.dart';
import 'package:chat_application_yt/service/auth_service.dart';
import 'package:chat_application_yt/service/database%20_service.dart';
import 'package:chat_application_yt/widgets/image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-page';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final textInputDec = const InputDecoration(
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.pink, width: 2)),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.pink, width: 2)),
    errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.pink, width: 2)),
    border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.pink, width: 2)),
    labelStyle: TextStyle(color: Colors.black),
  );
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String userName = '';
  Future<SharedPreferences> sp = SharedPreferences.getInstance();
  bool isLoading = false;
  var IsLogin = true;
  AuthService authService = AuthService();
  void _login() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = !isLoading;
      });

      authService
          .signUpOrLogin(userName, email, password, IsLogin, context)
          .then((value) async {
        if (value == true) {
          if (IsLogin) {
            QuerySnapshot snapshot = await DataBaseService(
                    uid: FirebaseAuth.instance.currentUser!.uid)
                .gettingUserData(email);
            userName = snapshot.docs[0]['fullname'];
            HelperFuction.saveUserName(userName);
          } else {
            HelperFuction.saveUserName(userName);
          }
          HelperFuction.saveUserLoggedInStatus(true);
          HelperFuction.saveUserEmail(email);
          HelperFuction.saveUserName(userName);
          // ignore: use_build_context_synchronously
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        } else {
          setState(() {
            isLoading = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Goupie',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Get Started !!!',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              const ImageLoad(),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
                decoration: textInputDec.copyWith(
                    label: const Text('Email'),
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Colors.pink,
                    )),
                validator: (value) {
                  if (!value!.contains('@') || !value.contains('.')) {
                    return 'Enter valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              if (!IsLogin)
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      userName = value;
                    });
                  },
                  decoration: textInputDec.copyWith(
                      label: const Text('Name'),
                      prefixIcon: const Icon(
                        Icons.account_box,
                        color: Colors.pink,
                      )),
                  validator: (value) {
                    if (value!.length < 3) {
                      return 'User name should be 3 characters long';
                    }
                    return null;
                  },
                ),
              if (!IsLogin)
                const SizedBox(
                  height: 20,
                ),
              TextFormField(
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
                decoration: textInputDec.copyWith(
                    label: const Text('Password'),
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Colors.pink,
                    )),
                validator: (value) {
                  if (value!.length < 6) {
                    return 'Password must be 6 characters long';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              if (isLoading)
                const CircularProgressIndicator(color: Colors.pinkAccent),
              if (!isLoading)
                SizedBox(
                  height: 35,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    child: Text(IsLogin ? 'Login' : 'Sign Up'),
                    onPressed: () {
                      _login();
                    },
                  ),
                ),
              if (!isLoading)
                const SizedBox(
                  height: 10,
                ),
              if (!isLoading)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(IsLogin
                        ? "Don't have an account ?"
                        : 'Already have an account ?'),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            IsLogin = !IsLogin;
                          });
                        },
                        child: Text(
                          IsLogin ? 'Sign up' : 'Login',
                          style: const TextStyle(
                              color: Colors.pink, fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
            ],
          ),
        ),
      ),
    ));
  }
}
