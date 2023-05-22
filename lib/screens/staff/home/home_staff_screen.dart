import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:staff_cleaner/component/slider/corousel_staff_component.dart';
import 'package:staff_cleaner/screens/autentikasi/login/login_screen.dart';
import 'package:staff_cleaner/values/navigate_utils.dart';
import 'package:staff_cleaner/values/screen_utils.dart';

import '../../../component/text/text_component.dart';
import '../../../services/firebase_services.dart';
import '../../../values/constant.dart';
import '../../../values/output_utils.dart';
import '../../../values/widget_utils.dart';

class HomeStaffScreen extends StatefulWidget {
  const HomeStaffScreen({super.key});

  @override
  State<HomeStaffScreen> createState() => _HomeStaffScreenState();
}

class _HomeStaffScreenState extends State<HomeStaffScreen> {
  final fs = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    final user = fs.getUser();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: 1.0.w,
        height: 1.0.h,
        child: Column(
          children: [
            Stack(children: [
              SizedBox(
                  height: 0.26.h,
                  width: 1.0.w,
                  child: const Image(image: AssetImage('assets/images/bg_home_staff.png'))),
              Positioned(
                  top: 0.06.h,
                  left: 0.86.w,
                  child: IconButton(
                      onPressed: () {
                        fs.signOut();
                        navigatePushAndRemove(const LoginScreen());
                      },
                      icon: const Icon(
                        Icons.logout,
                        color: Colors.white,
                      ))),
              Positioned(
                  top: 0.1.h,
                  left: 16,
                  child: const TextComponent("Jadwal Pekerjaan", color: Colors.white))
            ]),
            V(24),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: fs.getDataQueryStream("data", "email_staff", user?.email),
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
