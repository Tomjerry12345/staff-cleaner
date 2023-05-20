import 'package:flutter/material.dart';

import '../../../../../component/slider/corousel_admin_component.dart';
import '../../../../../component/slider/corousel_staff_component.dart';
import '../../../../../values/data_testing.dart';

class JadwalScreen extends StatefulWidget {
  const JadwalScreen({super.key});

  @override
  State<JadwalScreen> createState() => _JadwalScreenState();
}

class _JadwalScreenState extends State<JadwalScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          CorouselAdminComponent(
            items: dataJadwal,
            showItems: [
              {"title": "Nama customer", "key": "nama_customer"},
              {"title": "Layanan", "key": "layanan"},
              {"title": "Alamat", "key": "alamat_lengkap"},
            ],
            type: "jadwal",
          )
        ],
      ),
    );
  }
}
