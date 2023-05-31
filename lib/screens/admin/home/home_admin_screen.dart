import 'package:flutter/material.dart';
import 'package:staff_cleaner/screens/admin/home/section/jadwal/jadwal_screen.dart';
import 'package:staff_cleaner/screens/admin/home/section/selesai/selesai_screen.dart';
import 'package:staff_cleaner/values/screen_utils.dart';

import '../../../component/text/text_component.dart';
import '../../../services/firebase_services.dart';
import '../../../values/color.dart';
import '../../../values/navigate_utils.dart';
import '../../autentikasi/login/login_screen.dart';

class HomeAdminScreen extends StatefulWidget {
  const HomeAdminScreen({super.key});

  @override
  State<HomeAdminScreen> createState() => _HomeAdminScreenState();
}

class _HomeAdminScreenState extends State<HomeAdminScreen> {
  final fs = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: primaryColor,
            elevation: 0,
            toolbarHeight: 0.16.h,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TextComponent(
                  "Admin",
                  color: Colors.white,
                ),
                Positioned(
                    top: 0.06.h,
                    left: 0.86.w,
                    child: IconButton(
                        onPressed: () {
                          fs.signOut();
                          navigatePushAndRemove(LoginScreen());
                        },
                        icon: const Icon(Icons.logout))),
              ],
            ),
            bottom: const TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                    color: Colors.white),
                tabs: [
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Di jadwalkan"),
                    ),
                  ),
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Selesai"),
                    ),
                  ),
                ]),
          ),
          body: const Padding(
            padding: EdgeInsets.only(top: 24),
            child: TabBarView(children: [JadwalScreen(), SelesaiScreen()]),
          )),
    );
  }
}
