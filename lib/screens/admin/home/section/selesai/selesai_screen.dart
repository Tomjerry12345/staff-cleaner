import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../component/slider/corousel_admin_component.dart';
import '../../../../../services/firebase_services.dart';
import '../../../../../values/constant.dart';

class SelesaiScreen extends StatefulWidget {
  const SelesaiScreen({super.key});

  @override
  State<SelesaiScreen> createState() => _SelesaiScreenState();
}

class _SelesaiScreenState extends State<SelesaiScreen> {
  final fs = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: fs.getDataQueryStream("data", "selesai", true),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data!.docs;
                  return CorouselAdminComponent(
                      items: data,
                      showItems: [
                        {"title": "Nama customer", "key": "nama_lengkap"},
                        {"title": "Nama Staff Yang bertugas", "key": "nama_staff"},
                        {"title": "Alamat", "key": "alamat_lengkap"},
                      ],
                      type: "selesai");
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
