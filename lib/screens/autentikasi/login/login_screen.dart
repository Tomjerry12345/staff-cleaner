import 'package:flutter/material.dart';
import 'package:staff_cleaner/screens/admin/admin_main.dart';
import 'package:staff_cleaner/screens/autentikasi/register/register_screen.dart';
import 'package:staff_cleaner/services/firebase_services.dart';
import 'package:staff_cleaner/values/screen_utils.dart';

import '../../../component/button/button_component.dart';
import '../../../component/button/link_component.dart';
import '../../../component/text/text_component.dart';
import '../../../component/textfield/textfield_password_component.dart';
import '../../../values/color.dart';
import '../../../component/textfield/textfield_component.dart';
import '../../../values/kunci_utils.dart';
import '../../../values/navigate_utils.dart';
import '../../../values/output_utils.dart';
import '../../../values/widget_utils.dart';
import '../../staff/staff_main.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    final fs = FirebaseServices();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            height: 1.0.h,
            width: 1.0.w,
            color: backgroundAutentikasiColor,
            child: Padding(
              padding: const EdgeInsets.only(top: 48, left: 16, right: 16),
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
                    "Silahkan login terlebih",
                  ),
                  const TextComponent(
                    "dahulu",
                  ),
                  V(0.08.h),
                  TextfieldComponent(
                    hintText: "Masukkan email anda...",
                    onChanged: (value) {},
                    controller: emailController,
                  ),
                  V(0.04.h),
                  TextfieldPasswordComponent(
                    hintText: "Masukkan password anda...",
                    onChanged: (value) {},
                    controller: passwordController,
                  ),
                  V(0.04.h),
                  Center(
                      child: ButtonElevatedComponent(
                    "Login",
                    onPressed: () async {
                      try {
                        showLoaderDialog(context);
                        final getEmail = emailController.text;
                        final getPassword = passwordController.text;

                        final res = await fs.signInWithEmailAndPassword(getEmail, getPassword);
                        final user = res.user;
                        if (user?.email == "admin@gmail.com") {
                          navigatePushAndRemove(const AdminMain());
                        } else {
                          navigatePushAndRemove(const StaffMain());
                        }
                      } catch (e) {
                        showToast(e.toString());
                        closeDialog(context);
                      }
                    },
                  )),
                  V(0.04.h),
                  // Center(
                  //     child: TextComponent(
                  //   "Lupa password",
                  //   size: 16,
                  //   color: linkColor,
                  // )),
                  V(0.04.h),
                  const TextComponent(
                    "Belum punya akun ?",
                    size: 16,
                  ),
                  V(4),
                  Row(
                    children: [
                      const TextComponent(
                        "Silahkan",
                        size: 16,
                      ),
                      LinkComponent("daftar", onTap: () {
                        navigatePush(const RegisterScreen());
                      }),
                      const TextComponent(
                        "Terlebih dahulu",
                        size: 16,
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }
}
