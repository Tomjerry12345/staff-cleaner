// ignore_for_file: avoid_print

import 'dart:collection';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices {
  final _db = FirebaseFirestore.instance;

  Stream<User?> checkLogged() {
    return FirebaseAuth.instance.authStateChanges();
  }

  void addDataCollection(String collection, HashMap<String, dynamic> data) {
    _db
        .collection(collection)
        .add(data)
        .then((DocumentReference doc) => print('DocumentSnapshot added with ID: ${doc.id}'));
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getDataStreamCollection(String collection) =>
      _db.collection(collection).snapshots();

  Stream<QuerySnapshot<Map<String, dynamic>>> getDataQueryStream(
          String collection, String query, dynamic value) =>
      _db.collection(collection).where(query, isEqualTo: value).snapshots();

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getDataCollection(
      String collection, String query, dynamic value) async {
    final data = await _db.collection(collection).where(query, isEqualTo: value).get();

    return data.docs;
  }

  void updateDataCollection(String collection, String query, dynamic value) {
    _db
        .collection(collection)
        .where(query, isEqualTo: value)
        .get()
        .then((res) => res.docs[0].data().update(query, value));
  }
}
