import 'package:chat_application_yt/helper/helper_fuctionn.dart';
import 'package:chat_application_yt/service/database%20_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future signUpOrLogin(String fullName, String email, String password,
      bool isLogin, BuildContext context) async {
    try {
      if (!isLogin) {
        await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        User user = firebaseAuth.currentUser!;
        if (user != null) {
          await DataBaseService(uid: user.uid).updateUserDta(fullName, email);
          return true;
        }
      } else {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        User user = firebaseAuth.currentUser!;
        if (user != null) {
          return true;
        }
      }
    } on FirebaseException catch (err) {
      return ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(err.message!)));
    } catch (err) {
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Something went wrong'),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future signOut(BuildContext context) async {
    try {
      HelperFuction.saveUserLoggedInStatus(false);
      await firebaseAuth.signOut();
    } catch (er) {
      return ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Something went wrong')));
    }
  }
}
