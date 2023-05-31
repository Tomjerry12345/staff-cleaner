import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:staff_cleaner/component/slider/component/body_corousel.dart';
import 'package:staff_cleaner/component/text/text_component.dart';
import 'package:staff_cleaner/screens/staff/home/section/detail/detail_screen.dart';
import 'package:staff_cleaner/values/navigate_utils.dart';
import 'package:staff_cleaner/values/screen_utils.dart';

import '../../screens/staff/home/section/nota/nota_staff_screen.dart';
import '../../services/firebase_services.dart';
import '../../values/color.dart';
import '../../values/output_utils.dart';

class CorouselStaffComponent extends StatelessWidget {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>>? items;
  final List<Map>? showItems;
  const CorouselStaffComponent({super.key, this.items, this.showItems});

  @override
  Widget build(BuildContext context) {
    final noSurat = TextEditingController();
    final noSurat1 = TextEditingController();

    final fs = FirebaseServices();
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: false,
        aspectRatio: .85,
        enlargeCenterPage: true,
      ),
      items: items
          ?.map((item) => Card(
                elevation: 8,
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                    debugPrint('Card tapped.');
                  },
                  child: SizedBox(
                    width: 0.8.w,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              onPressed: () {
                                // var noSurat = "031/INV/YBS/121123";
                                final user = fs.getUser();

                                showDialogNoSurat(context, noSurat, noSurat1, () {
                                  navigatePush(NotaStaffScreen(
                                      noSurat: "${noSurat.text}/INV/YBS/${noSurat1.text}",
                                      item: item,
                                      user: user));

                                  noSurat.text = "";
                                  noSurat1.text = "";
                                });
                              },
                              icon: const Icon(Icons.speaker_notes),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: showItems!
                                .map((e) => BodyCorousel(e["title"], item[e["key"]]))
                                .toList(),
                          ),
                          Align(
                              alignment: Alignment.bottomRight,
                              child: TextButton(
                                onPressed: () {
                                  navigatePush(DetailScreen(item: item));
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextComponent('Detail',
                                        size: 16, color: primaryColor), // <-- Text
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                        // <-- Icon
                                        Icons.arrow_right_outlined,
                                        color: primaryColor),
                                  ],
                                ),
                              )),
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
