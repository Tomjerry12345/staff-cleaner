import 'package:flutter/material.dart';
import 'package:staff_cleaner/values/screen_utils.dart';

import '../../../component/text/text_component.dart';
import '../../../values/color.dart';

class ListUserStaff extends StatefulWidget {
  const ListUserStaff({super.key});

  @override
  State<ListUserStaff> createState() => _ListUserStaffState();
}

class _ListUserStaffState extends State<ListUserStaff> {
  List<String> titles = ["Kerdil", "Deceng", "Amrul"];
  List<String> subtitles = ["Di jadwalkan", "Belum di jadwalkan", "Di jadwalkan"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          toolbarHeight: 0.18.h,
          title: TextComponent(
            "Staff",
            color: Colors.white,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView.builder(
              itemCount: titles.length,
              itemBuilder: (context, index) {
                return Card(
                    child: ListTile(
                  onTap: () {
                    setState(() {
                      titles.add('List' + (titles.length + 1).toString());
                    });
                  },
                  title: Text(titles[index]),
                  subtitle: Text(subtitles[index]),
                  leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://images.unsplash.com/photo-1547721064-da6cfb341d50")),
                  // trailing: Icon(icons[index])
                ));
              }),
        ));
  }
}
