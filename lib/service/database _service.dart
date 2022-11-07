import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService {
  String? uid;
  DataBaseService({this.uid});
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection('groups');

  Future updateUserDta(String fullName, String email) async {
    return await userCollection.doc(uid).set({
      'fullname': fullName,
      'email': email,
      'groups': null,
      'profilepic': null,
      'uid': uid,
    });
  }

  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where('email', isEqualTo: email).get();
    return snapshot;
  }

  Future getUserGroup() async {
    return userCollection.doc(uid).snapshots();
  }

  Future createGroup(String userNmae, String id, String groupName) async {
    DocumentReference groupDocumentReference = await groupCollection.add({
      "groupName": groupName,
      "groupIcon": "",
      "admin": "${id}_$userNmae",
      "members": [],
      "groupId": '',
      "recentMessage": null,
      "recentMessageSender": null
    });
    await groupDocumentReference.update({
      "memebers": FieldValue.arrayUnion(["${uid}_$userNmae"]),
      'groupId': groupDocumentReference.id,
    });
    DocumentReference userDocumentReference = await userCollection.doc(uid);
    return await userDocumentReference.update({
      "groups":
          FieldValue.arrayUnion(["${groupDocumentReference.id}_$groupName"])
    });
  }

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getChat(
      String groupId) async {
    return await groupCollection
        .doc(groupId)
        .collection('messages')
        .orderBy('time')
        .snapshots();
  }

  Future getAdmin(String groupId) async {
    DocumentReference d = groupCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await d.get();
    return documentSnapshot['admin'];
  }
  
}
