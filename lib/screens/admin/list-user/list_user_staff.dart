import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:staff_cleaner/values/screen_utils.dart';

import '../../../component/text/text_component.dart';
import '../../../services/firebase_services.dart';
import '../../../values/color.dart';
import '../../../values/widget_utils.dart';

class ListUserStaff extends StatefulWidget {
  const ListUserStaff({super.key});

  @override
  State<ListUserStaff> createState() => _ListUserStaffState();
}

class _ListUserStaffState extends State<ListUserStaff> {
  List<String> titles = ["Kerdil", "Deceng", "Amrul"];
  List<String> subtitles = ["Di jadwalkan", "Belum di jadwalkan", "Di jadwalkan"];

  final fs = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          toolbarHeight: 0.18.h,
          title: const TextComponent(
            "Staff",
            color: Colors.white,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: fs.getDataStreamCollection("staff"),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final snap = snapshot.data as QuerySnapshot<Map<String, dynamic>>;
                  final data = snap.docs;
                  return ListView.builder(
                      itemCount: snap.size,
                      itemBuilder: (context, index) {
                        return Card(
                            child: ListTile(
                          onTap: () {},
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: TextComponent(
                              data[index]["nama_lengkap"],
                              size: 18,
                            ),
                          ),
                          subtitle: data[index]["bertugas"] == true
                              ? TextComponent("Di jadwalkan", size: 14, color: primaryColor)
                              : TextComponent("Belum di jadwalkan", size: 14, color: Colors.red),
                          leading:
                              CircleAvatar(backgroundImage: NetworkImage(data[index]["image"])),
                          // trailing: Icon(icons[index])
                        ));
                      });
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ));
  }
}
