import 'package:flutter/material.dart';
import 'package:staff_cleaner/values/screen_utils.dart';
import '../../../../component/button/button_component.dart';
import '../../../../component/button/link_component.dart';
import '../../../../component/text/card_text_component.dart';
import '../../../../component/text/text_component.dart';
import '../../../../values/color.dart';
import '../../../../values/font_custom.dart';
import '../../../../values/navigate_utils.dart';
import '../../../../values/widget_utils.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
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
                "Detail",
                color: Colors.white,
              ),
              V(32),
              const CardTextComponent("Nama lengkap", "test"),
              V(16),
              const CardTextComponent("Tanggal lahir", "01/02/2023"),
              V(16),
              const CardTextComponent("No. handphone", "085753845575"),
              V(16),
              const CardTextComponent("Layanan", "Deep Hydroallergic Vacuum"),
              V(16),
              const CardTextComponent("Tanggal layanan", "01/02/2023"),
              V(16),
              const CardTextComponent("Jam layanan", "08:00"),
              V(16),
              const TextComponent(
                "Item yang akan di bersihkan: ",
                size: 18,
                color: Colors.white,
              ),
              V(8),
              Card(
                elevation: 8,
                clipBehavior: Clip.hardEdge,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 1.0.w,
                    child: TextComponent(
                      "1. kasur",
                      size: 16,
                      weight: Lato.Light,
                    ),
                  ),
                ),
              ),
              V(8),
              Card(
                elevation: 8,
                clipBehavior: Clip.hardEdge,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 1.0.w,
                    child: TextComponent(
                      "2. kursi",
                      size: 16,
                      weight: Lato.Light,
                    ),
                  ),
                ),
              ),
              V(24),
              const CardTextComponent("Daya", "2220 watt"),
              V(16),
              const CardTextComponent("Mengetahui yukbersihin dari ?", "instagram"),
              V(16),
              const CardTextComponent("Alamat lengkap",
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
