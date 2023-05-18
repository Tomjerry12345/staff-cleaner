import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:staff_cleaner/component/slider/component/body_corousel.dart';
import 'package:staff_cleaner/component/text/text_component.dart';
import 'package:staff_cleaner/screens/admin/home/section/section/detail_jadwal_customer.dart';
import 'package:staff_cleaner/screens/staff/home/detail/detail_screen.dart';
import 'package:staff_cleaner/values/navigate_utils.dart';
import 'package:staff_cleaner/values/screen_utils.dart';

import '../../values/color.dart';

class CorouselAdminComponent extends StatefulWidget {
  final List<Map>? items;
  final List<Map>? showItems;
  const CorouselAdminComponent({super.key, this.items, this.showItems});

  @override
  State<CorouselAdminComponent> createState() => _CorouselAdminComponentState();
}

class _CorouselAdminComponentState extends State<CorouselAdminComponent> {
  bool checkedSelesai = false;
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: false,
        aspectRatio: .85,
        enlargeCenterPage: true,
      ),
      items: widget.items
          ?.map((item) => Card(
                elevation: 8,
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  // onTap: () {
                  //   debugPrint('Card tapped.');
                  // },
                  child: SizedBox(
                    width: 0.8.w,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Checkbox(
                                value: checkedSelesai,
                                onChanged: (bool? value) {
                                  print("test");
                                  setState(() {
                                    checkedSelesai = value!;
                                  });
                                }),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: widget.showItems!
                                .map((e) =>
                                    BodyCorousel(e["title"], item[e["key"]]))
                                .toList(),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextComponent(
                                  "${item["tanggal_layanan"]} ${item["jam_layanan"]}",
                                  size: 16,
                                ),
                                TextButton(
                                  onPressed: () {
                                    navigatePush(DetailJadwalCustomer(
                                      item: item,
                                    ));
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextComponent('Detail',
                                          size: 16,
                                          color: primaryColor), // <-- Text
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                          // <-- Icon
                                          Icons.arrow_right_outlined,
                                          color: primaryColor),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }
}
