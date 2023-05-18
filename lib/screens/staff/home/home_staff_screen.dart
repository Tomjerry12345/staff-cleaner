import 'package:flutter/material.dart';
import 'package:staff_cleaner/component/slider/corousel_staff_component.dart';
import 'package:staff_cleaner/values/screen_utils.dart';

import '../../../component/text/text_component.dart';
import '../../../values/widget_utils.dart';

class HomeStaffScreen extends StatefulWidget {
  const HomeStaffScreen({super.key});

  @override
  State<HomeStaffScreen> createState() => _HomeStaffScreenState();
}

class _HomeStaffScreenState extends State<HomeStaffScreen> {
  @override
  Widget build(BuildContext context) {
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
                  child: const Image(
                      image: AssetImage('assets/images/bg_home_staff.png'))),
              Positioned(
                  top: 0.1.h,
                  left: 16,
                  child: const TextComponent("Jadwal Pekerjaan"))
            ]),
            V(24),
            const CorouselStaffComponent()
          ],
        ),
      ),
    );
  }
}
