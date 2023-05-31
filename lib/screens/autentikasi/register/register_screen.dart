import 'dart:io';

import 'package:flutter/material.dart';
import 'package:staff_cleaner/values/screen_utils.dart';

import '../../../component/button/avatar_component.dart';
import '../../../component/button/button_component.dart';
import '../../../component/button/link_component.dart';
import '../../../component/text/text_component.dart';
import '../../../component/textfield/textfield_component.dart';
import '../../../component/textfield/textfield_date_component.dart';
import '../../../component/textfield/textfield_password_component.dart';
import '../../../services/firebase_services.dart';
import '../../../values/color.dart';
import '../../../values/navigate_utils.dart';
import '../../../values/output_utils.dart';
import '../../../values/widget_utils.dart';
import '../../staff/staff_main.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final namaLengkapController = TextEditingController();
  final noHpController = TextEditingController();
  final tanggalLahirController = TextEditingController();

  File? getImage;

  final fs = FirebaseServices();
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
                  Center(
                      child: AvatarComponent(
                    'https://www.seekpng.com/png/detail/17-176376_person-free-download-and-person-icon-png.png',
                    icon: Icons.add_a_photo,
                    onGetImage: (image) {
                      setState(() {
                        getImage = image;
                      });
                    },
                  )),
                  V(0.06.h),
                  TextfieldComponent(
                    hintText: "Masukkan email anda...",
                    onChanged: (value) {},
                    controller: emailController,
                  ),
                  V(0.02.h),
                  TextfieldPasswordComponent(
                    hintText: "Masukkan password anda...",
                    onChanged: (value) {},
                    controller: passwordController,
                  ),
                  V(0.02.h),
                  TextfieldComponent(
                    hintText: "Nama lengkap...",
                    onChanged: (value) {},
                    controller: namaLengkapController,
                  ),
                  V(0.02.h),
                  TextfieldComponent(
                    hintText: "No handphone...",
                    inputType: TextInputType.phone,
                    onChanged: (value) {},
                    controller: noHpController,
                  ),
                  V(0.02.h),
                  TextfieldDateComponent(
                    hintText: "Tanggal lahir...",
                    onChanged: (value) {},
                    controller: tanggalLahirController,
                  ),
                  V(0.02.h),
                  Center(
                      child: ButtonElevatedComponent(
                    "Daftar",
                    onPressed: () async {
                      try {
                        showLoaderDialog(context);
                        await fs.registerWithEmailAndPassword(
                            emailController.text, passwordController.text);

                        String urlImage =
                            "https://www.seekpng.com/png/detail/17-176376_person-free-download-and-person-icon-png.png";
                        if (getImage != null) {
                          urlImage = await fs.uploadFile(getImage!, "images");
                        }

                        Map<String, dynamic> data = {
                          "image": urlImage,
                          "email": emailController.text,
                          "nama_lengkap": namaLengkapController.text,
                          "no_hp": noHpController.text,
                          "tanggal_lahir": tanggalLahirController.text,
                          "bertugas": false
                        };

                        await fs.addDataCollection("staff", data);
                        navigatePushAndRemove(const StaffMain());
                      } catch (e) {
                        closeDialog(context);
                        showToast(e.toString());
                      }
                    },
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
