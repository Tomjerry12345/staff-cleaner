import 'package:flutter/material.dart';
import 'package:staff_cleaner/values/screen_utils.dart';

import '../../../component/button/avatar_component.dart';
import '../../../component/button/button_component.dart';
import '../../../component/button/link_component.dart';
import '../../../component/text/text_component.dart';
import '../../../component/textfield/textfield_component.dart';
import '../../../component/textfield/textfield_password_component.dart';
import '../../../values/color.dart';
import '../../../values/navigate_utils.dart';
import '../../../values/widget_utils.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          color: backgroundAutentikasiColor,
          height: 1.0.h,
          width: 1.0.w,
          child: Padding(
            padding: const EdgeInsets.only(top: 48, left: 16, right: 16, bottom: 48),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: SizedBox(
                      width: 0.6.w,
                      height: 0.2.h,
                      child: const Image(image: AssetImage('assets/images/logo.png')),
                    ),
                  ),
                  const TextComponent(
                    "Silahkan lengkapi form di",
                  ),
                  const TextComponent(
                    "bawah ini",
                  ),
                  V(0.07.h),
                  const Center(
                      child: AvatarComponent(
                          'https://staticg.sportskeeda.com/editor/2022/11/a402f-16694231050443-1920.jpg',
                          icon: Icons.add_a_photo)),
                  V(0.06.h),
                  TextfieldComponent(
                    hintText: "Masukkan email anda...",
                    onChanged: (value) {},
                  ),
                  V(0.02.h),
                  TextfieldPasswordComponent(
                    hintText: "Masukkan password anda...",
                    onChanged: (value) {},
                  ),
                  V(0.02.h),
                  TextfieldComponent(
                    hintText: "Nama lengkap...",
                    onChanged: (value) {},
                  ),
                  V(0.02.h),
                  TextfieldComponent(
                    hintText: "No handphone...",
                    onChanged: (value) {},
                  ),
                  V(0.02.h),
                  TextfieldComponent(
                    hintText: "Tanggal lahir...",
                    onChanged: (value) {},
                  ),
                  V(0.02.h),
                  Center(
                      child: ButtonElevatedComponent(
                    "Daftar",
                    onPressed: () {},
                  )),
                  V(0.05.h),
                  const TextComponent(
                    "Sudah punya akun ?",
                    size: 16,
                  ),
                  V(4),
                  Row(
                    children: [
                      const TextComponent(
                        "Silahkan",
                        size: 16,
                      ),
                      LinkComponent("login", onTap: () {
                        navigatePop();
                      }),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
