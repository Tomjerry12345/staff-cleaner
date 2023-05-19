import 'package:flutter/material.dart';
import 'package:staff_cleaner/values/screen_utils.dart';

import '../../../component/button/button_component.dart';
import '../../../component/button/link_component.dart';
import '../../../component/text/text_component.dart';
import '../../../component/textfield/textfield_component.dart';
import '../../../values/color.dart';
import '../../../values/data_testing.dart';
import '../../../values/font_custom.dart';
import '../../../values/navigate_utils.dart';
import '../../../values/widget_utils.dart';

class TambahDataCustomer extends StatelessWidget {
  const TambahDataCustomer({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<dynamic, dynamic>> itemYangDibersihkan = dataJadwal[0]["item_yang_dibersihkan"];

    return Scaffold(
      body: Container(
        width: 1.0.w,
        height: 1.0.h,
        color: primaryColor,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const TextComponent(
                "Tambah Data",
                color: Colors.white,
              ),
              V(32),
              TextfieldComponent(
                hintText: "Nama lengkap...",
                onChanged: (value) {},
                color: Colors.white,
                // controller: emailController,
              ),
              V(16),
              TextfieldComponent(
                hintText: "Tanggal lahir...",
                onChanged: (value) {},
                color: Colors.white,
                // controller: emailController,
              ),
              V(16),
              TextfieldComponent(
                hintText: "No. handphone...",
                onChanged: (value) {},
                color: Colors.white,
                // controller: emailController,
              ),
              V(16),
              TextfieldComponent(
                hintText: "Staff yang melayani...",
                onChanged: (value) {},
                color: Colors.white,
                // controller: emailController,
              ),
              V(16),
              TextfieldComponent(
                hintText: "Layanan...",
                onChanged: (value) {},
                color: Colors.white,
                // controller: emailController,
              ),
              V(16),
              TextfieldComponent(
                hintText: "Tanggal layanan...",
                onChanged: (value) {},
                color: Colors.white,
                // controller: emailController,
              ),
              V(16),
              TextfieldComponent(
                hintText: "Jam layanan...",
                onChanged: (value) {},
                color: Colors.white,
                // controller: emailController,
              ),
              V(16),
              TextComponent(
                "Item yang akan di bersihkan: ",
                size: 18,
                color: Colors.white,
              ),
              V(8),
              Column(
                children: itemYangDibersihkan
                    .map((e) => Column(
                          children: [
                            Card(
                              elevation: 8,
                              clipBehavior: Clip.hardEdge,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: 1.0.w,
                                  child: TextComponent(
                                    "1. ${e["nama_item"]}",
                                    size: 16,
                                    weight: Lato.Light,
                                  ),
                                ),
                              ),
                            ),
                            V(8)
                          ],
                        ))
                    .toList(),
              ),
              V(8),
              Center(
                child: ButtonElevatedComponent(
                  "Tambah item",
                  onPressed: () {
                    navigatePop();
                  },
                ),
              ),
              V(24),
              TextfieldComponent(
                hintText: "Daya...",
                onChanged: (value) {},
                color: Colors.white,
                // controller: emailController,
              ),
              V(16),
              TextfieldComponent(
                hintText: "Mengetahui yuk bersihin dari ?...",
                onChanged: (value) {},
                color: Colors.white,
                // controller: emailController,
              ),
              V(16),
              TextfieldComponent(
                hintText: "Alamat lengkap...",
                onChanged: (value) {},
                color: Colors.white,
                // controller: emailController,
              ),
              V(32),
              Center(
                child: LinkComponent(
                  "Lihat Lokasi >",
                  onTap: () {},
                ),
              ),
              V(32),
              Center(
                child: ButtonElevatedComponent(
                  "kembali",
                  onPressed: () {
                    navigatePop();
                  },
                ),
              )
            ]),
          ),
        ),
      ),
    );
    ;
  }
}
