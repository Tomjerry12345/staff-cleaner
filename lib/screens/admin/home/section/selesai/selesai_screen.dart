import 'package:flutter/material.dart';

import '../../../../../component/slider/corousel_admin_component.dart';
import '../../../../../values/constant.dart';

class SelesaiScreen extends StatefulWidget {
  const SelesaiScreen({super.key});

  @override
  State<SelesaiScreen> createState() => _SelesaiScreenState();
}

class _SelesaiScreenState extends State<SelesaiScreen> {
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
              type: "selesai")
        ],
      ),
    );
  }
}
