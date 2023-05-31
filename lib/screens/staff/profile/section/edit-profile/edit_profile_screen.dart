import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:staff_cleaner/screens/staff/profile/profil_screen.dart';
import 'package:staff_cleaner/screens/staff/staff_main.dart';
import 'package:staff_cleaner/values/screen_utils.dart';

import '../../../../../component/button/button_component.dart';
import '../../../../../component/text/text_component.dart';
import '../../../../../component/textfield/textfield_component.dart';
import '../../../../../component/textfield/textfield_date_component.dart';
import '../../../../../services/firebase_services.dart';
import '../../../../../values/color.dart';
import '../../../../../values/navigate_utils.dart';
import '../../../../../values/output_utils.dart';
import '../../../../../values/widget_utils.dart';

class EditPofileScreen extends StatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> data;
  const EditPofileScreen({super.key, required this.data});

  @override
  State<EditPofileScreen> createState() => _EditPofileScreenState();
}

class _EditPofileScreenState extends State<EditPofileScreen> {
  final namaLengkapController = TextEditingController();
  final noHpController = TextEditingController();
  final tanggalLahirController = TextEditingController();

  File? getImage;

  final fs = FirebaseServices();

  @override
  void initState() {
    super.initState();
    namaLengkapController.text = widget.data["nama_lengkap"];
    noHpController.text = widget.data["no_hp"];
    tanggalLahirController.text = widget.data["tanggal_lahir"];
  }

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const TextComponent(
                  "Edit Profile",
                ),
                V(0.07.h),

                // TextfieldComponent(
                //   hintText: "Masukkan email anda...",
                //   onChanged: (value) {},
                //   controller: emailController,
                // ),
                // V(0.02.h),
                // TextfieldPasswordComponent(
                //   hintText: "Masukkan password anda...",
                //   onChanged: (value) {},
                //   controller: passwordController,
                // ),
                // V(0.02.h),
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
                  "Edit",
                  onPressed: () async {
                    try {
                      showLoaderDialog(context);
                      Map<String, dynamic> data = {
                        "nama_lengkap": namaLengkapController.text,
                        "no_hp": noHpController.text,
                        "tanggal_lahir": tanggalLahirController.text,
                      };
                      await fs.updateDataSpecifictDoc("staff", widget.data.id, data);

                      navigatePushAndRemove(const StaffMain(
                        initialPage: 1,
                      ));
                    } catch (e) {
                      closeDialog(context);
                      showToast(e.toString());
                    }
                  },
                )),
              ],
            ),
          )),
    );
    ;
  }
}
