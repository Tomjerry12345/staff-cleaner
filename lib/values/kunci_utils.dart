import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/firebase_services.dart';

StreamBuilder<DocumentSnapshot<Map<String, dynamic>>> kunciUtils(page) {
  FirebaseServices fs = FirebaseServices();
  return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: fs.getDataStreamDoc("kunci", "555"),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final kunci = snapshot.data!["kunci"];

          if (kunci == false) {
            return page;
          } else {
            // return const KunciPage();
          }
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      });
}
