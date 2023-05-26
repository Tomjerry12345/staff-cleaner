import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../component/slider/corousel_admin_component.dart';
import '../../../../../services/firebase_services.dart';

class JadwalScreen extends StatefulWidget {
  const JadwalScreen({super.key});

  @override
  State<JadwalScreen> createState() => _JadwalScreenState();
}

class _JadwalScreenState extends State<JadwalScreen> {
  final fs = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: fs.getDataQueryStream("data", "selesai", false),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data!.docs;
                  return CorouselAdminComponent(
                    items: data,
                    showItems: const [
                      {"title": "Nama customer", "key": "nama_lengkap"},
                      {"title": "Nama Staff Yang bertugas", "key": "nama_staff"},
                      {"title": "Alamat", "key": "alamat_lengkap"},
                    ],
                    type: "jadwal",
                  );
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              })
        ],
      ),
    );
  }
}
