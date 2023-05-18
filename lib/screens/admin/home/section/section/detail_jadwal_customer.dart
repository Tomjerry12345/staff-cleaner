import 'package:flutter/material.dart';
import 'package:staff_cleaner/values/screen_utils.dart';

import '../../../../../component/button/button_component.dart';
import '../../../../../component/button/link_component.dart';
import '../../../../../component/text/card_text_component.dart';
import '../../../../../component/text/text_component.dart';
import '../../../../../values/color.dart';
import '../../../../../values/font_custom.dart';
import '../../../../../values/navigate_utils.dart';
import '../../../../../values/widget_utils.dart';

class DetailJadwalCustomer extends StatefulWidget {
  final Map item;
  const DetailJadwalCustomer({super.key, required this.item});

  @override
  State<DetailJadwalCustomer> createState() => _DetailJadwalCustomerState();
}

class _DetailJadwalCustomerState extends State<DetailJadwalCustomer> {
  @override
  Widget build(BuildContext context) {
    final itemYgDibersihlkan =
        widget.item["item_yang_dibersihkan"] as List<Map<String, dynamic>>;
    return Scaffold(
      body: Container(
        width: 1.0.w,
        height: 1.0.h,
        color: primaryColor,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const TextComponent(
                "Detail",
                color: Colors.white,
              ),
              V(32),
              CardTextComponent("Nama lengkap", widget.item["nama_customer"]),
              V(16),
              CardTextComponent("Tanggal lahir", widget.item["tanggal_lahir"]),
              V(16),
              CardTextComponent("No. handphone", widget.item["no_handphone"]),
              V(16),
              CardTextComponent(
                  "Staff Yang Melayani", widget.item["staff_yang_melayani"]),
              V(16),
              CardTextComponent("Layanan", widget.item["layanan"]),
              V(16),
              CardTextComponent(
                  "Tanggal layanan", widget.item["tanggal_layanan"]),
              V(16),
              CardTextComponent("Jam layanan", widget.item["jam_layanan"]),
              V(16),
              TextComponent(
                "Item yang akan di bersihkan: ",
                size: 18,
                color: Colors.white,
              ),
              V(8),
              Column(
                children: itemYgDibersihlkan
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
              V(24),
              CardTextComponent("Daya", "2220 watt"),
              V(16),
              CardTextComponent("Mengetahui yukbersihin dari ?", "instagram"),
              V(16),
              CardTextComponent("Alamat lengkap",
                  "Jl. Sunan Giri No.1, Rawamangun, Kec. Pulogadung, Kota Jakarta Timur, DKI Jakarta 13220"),
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
  }
}
