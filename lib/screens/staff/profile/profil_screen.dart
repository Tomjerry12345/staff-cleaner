import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:staff_cleaner/screens/staff/profile/component/section_data_profile.dart';
import 'package:staff_cleaner/screens/staff/profile/section/edit-profile/edit_profile_screen.dart';
import 'package:staff_cleaner/values/screen_utils.dart';

import '../../../component/button/avatar_component.dart';
import '../../../component/button/button_component.dart';
import '../../../component/text/text_component.dart';
import '../../../services/firebase_services.dart';
import '../../../values/font_custom.dart';
import '../../../values/navigate_utils.dart';
import '../../../values/output_utils.dart';
import '../../../values/widget_utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final fs = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    final user = fs.getUser();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: 1.0.w,
        height: 1.0.h,
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: fs.getDataQueryStream("staff", "email", user?.email),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data!.docs.first;
                logO("data", m: data["image"]);
                return Column(
                  children: [
                    Stack(children: [
                      SizedBox(
                          // height: 0.26.h,
                          width: 1.0.w,
                          child: const Image(image: AssetImage('assets/images/bg_profile.png'))),
                      Positioned(top: 0.07.h, left: 16, child: const TextComponent("Profile")),
                      SizedBox(
                        height: 0.38.h,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: AvatarComponent(
                            data["image"],
                            icon: Icons.add_photo_alternate,
                            colorIconBg: Colors.green,
                            onGetImage: (image) async {
                              try {
                                showLoaderDialog(context);
                                final urlImage = await fs.uploadFile(image, "images");

                                await fs
                                    .updateDataSpecifictDoc("staff", data.id, {"image": urlImage});
                                // ignore: use_build_context_synchronously
                                stopLoaderDialog(context);
                              } catch (err) {
                                logO("test", m: err);
                                showToast(err);
                                stopLoaderDialog(context);
                              }
                            },
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
                              Center(
                                child: TextComponent(
                                  data["nama_lengkap"],
                                  size: 18,
                                ),
                              ),
                              V(8),
                              Center(
                                child: TextComponent(
                                  data["email"],
                                  size: 16,
                                  weight: Lato.Light,
                                ),
                              ),
                              V(48),
                              SectionDataProfile(Icons.phone, data["no_hp"]),
                              V(16),
                              SectionDataProfile(Icons.calendar_month, data["tanggal_lahir"]),
                              V(48),
                              Center(
                                child: ButtonElevatedComponent(
                                  "Edit Data",
                                  onPressed: () {
                                    navigatePush(EditPofileScreen(
                                      data: data,
                                    ));
                                  },
                                ),
                              ),
                              V(16),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                );
              }

              return const Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}
