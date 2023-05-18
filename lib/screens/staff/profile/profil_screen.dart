import 'package:flutter/material.dart';
import 'package:staff_cleaner/screens/staff/profile/component/section_data_profile.dart';
import 'package:staff_cleaner/values/screen_utils.dart';

import '../../../component/button/avatar_component.dart';
import '../../../component/text/text_component.dart';
import '../../../values/font_custom.dart';
import '../../../values/widget_utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
                  // height: 0.26.h,
                  width: 1.0.w,
                  child: const Image(image: AssetImage('assets/images/bg_profile.png'))),
              Positioned(top: 0.07.h, left: 16, child: const TextComponent("Profile")),
              SizedBox(
                height: 0.38.h,
                child: const Align(
                  alignment: Alignment.bottomCenter,
                  child: AvatarComponent(
                    "https://i.pinimg.com/736x/50/08/ef/5008efb9df96969624d2674645027a3a.jpg",
                    icon: Icons.edit,
                    colorIconBg: Colors.green,
                  ),
                ),
              )
            ]),
            V(8),
            Card(
              elevation: 8,
              clipBehavior: Clip.hardEdge,
              child: SizedBox(
                width: 0.8.w,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: TextComponent(
                          "Monkey D Luffy",
                          size: 18,
                        ),
                      ),
                      V(8),
                      Center(
                        child: TextComponent(
                          "monkeydluffy@gmail.com",
                          size: 16,
                          weight: Lato.Light,
                        ),
                      ),
                      V(48),
                      const SectionDataProfile(Icons.phone, "085753845575"),
                      V(16),
                      const SectionDataProfile(Icons.apartment, "Makasar"),
                      V(16),
                      const SectionDataProfile(Icons.calendar_month, "02 Agustus 2023"),
                      V(16),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
