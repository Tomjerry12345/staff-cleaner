import 'package:flutter/material.dart';
import 'package:staff_cleaner/screens/admin/home/section/jadwal/jadwal_screen.dart';
import 'package:staff_cleaner/values/screen_utils.dart';

import '../../../component/text/text_component.dart';
import '../../../values/color.dart';
import '../../../values/widget_utils.dart';
import '../list-user/list_user_staff.dart';

class HomeAdminScreen extends StatefulWidget {
  const HomeAdminScreen({super.key});

  @override
  State<HomeAdminScreen> createState() => _HomeAdminScreenState();
}

class _HomeAdminScreenState extends State<HomeAdminScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: primaryColor,
            elevation: 0,
            toolbarHeight: 0.18.h,
            title: TextComponent(
              "Admin",
              color: Colors.white,
            ),
            bottom: TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
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
          body: TabBarView(children: [JadwalScreen(), ListUserStaff()])),
    );
  }
}
