import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../component/slider/corousel_staff_component.dart';
import '../../../../../services/firebase_services.dart';

class SelesaiStaffScreen extends StatefulWidget {
  const SelesaiStaffScreen({super.key});

  @override
  State<SelesaiStaffScreen> createState() => _SelesaiStaffScreenState();
}

class _SelesaiStaffScreenState extends State<SelesaiStaffScreen> {
  final fs = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    final user = fs.getUser();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream:
                    fs.getDataTwoQueryStream("data", "email_staff", user?.email, "selesai", true),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data!.docs;
                    return CorouselStaffComponent(
                      items: data,
                      showItems: const [
                        {"title": "Nama customer", "key": "nama_lengkap"},
                        {"title": "No Hp", "key": "no_hp"},
                        {"title": "Alamat", "key": "alamat_lengkap"},
                        {"title": "Tanggal layanan", "key": "tanggal_layanan"},
                        {"title": "Jam layanan", "key": "jam_layanan"},
                        {"title": "Daya", "key": "daya"},
                      ],
                    );
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                })
          ],
        ),
      ),
    );
  }
}
