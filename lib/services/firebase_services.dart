// ignore_for_file: avoid_print

import 'dart:collection';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class FirebaseServices {
  final _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? checkLogged() => _auth.currentUser;

  Future<void> signOut() => _auth.signOut();

  Future<UserCredential> registerWithEmailAndPassword(String email, String password) =>
      _auth.createUserWithEmailAndPassword(email: email, password: password);

  Future<UserCredential> signInWithEmailAndPassword(String email, String password) =>
      _auth.signInWithEmailAndPassword(email: email, password: password);

  Future addDataCollection(String collection, Map<String, dynamic> data) =>
      _db.collection(collection).add(data);

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

  Future uploadFile(File file, String type) async {
    String fileName = basename(file.path);
    final firebaseStorageRef = FirebaseStorage.instance.ref().child('$type/$fileName');
    final uploadTask = firebaseStorageRef.putFile(file);
    final taskSnapshot = uploadTask.snapshot.ref.getDownloadURL();
    return taskSnapshot;
  }
}
