import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:staff_cleaner/component/slider/component/body_corousel.dart';
import 'package:staff_cleaner/component/text/text_component.dart';
import 'package:staff_cleaner/screens/staff/home/detail/detail_screen.dart';
import 'package:staff_cleaner/values/navigate_utils.dart';
import 'package:staff_cleaner/values/screen_utils.dart';

import '../../values/color.dart';

// final List<String> imgList = [
//   'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
//   'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
//   'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
//   'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
//   'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
//   'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
// ];

// final List<Widget> imageSliders = imgList
//     .map((item) => Card(
//           elevation: 8,
//           clipBehavior: Clip.hardEdge,
//           child: InkWell(
//             splashColor: Colors.blue.withAlpha(30),
//             onTap: () {
//               debugPrint('Card tapped.');
//             },
//             child: SizedBox(
//               width: 0.8.w,
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Stack(
//                   children: [
//                     const Align(
//                       alignment: Alignment.topRight,
//                       child: Icon(Icons.speaker_notes),
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: const [
//                         BodyCorousel("Nama customer", "Monkey d luffy"),
//                         BodyCorousel("Layanan", "Deep Hydroallergic Vacuum"),
//                         BodyCorousel("Alamat",
//                             "Jl. Sunan Giri No.1, Rawamangun, Kec. Pulogadung, Kota Jakarta Timur, DKI Jakarta 13220"),
//                       ],
//                     ),
//                     Align(
//                         alignment: Alignment.bottomRight,
//                         child: TextButton(
//                           onPressed: () {
//                             navigatePush(const DetailScreen());
//                           },
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               TextComponent('Detail',
//                                   size: 16, color: primaryColor), // <-- Text
//                               const SizedBox(
//                                 width: 5,
//                               ),
//                               Icon(
//                                   // <-- Icon
//                                   Icons.arrow_right_outlined,
//                                   color: primaryColor),
//                             ],
//                           ),
//                         )),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ))
//     .toList();

class CorouselStaffComponent extends StatelessWidget {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>>? items;
  final List<Map>? showItems;
  const CorouselStaffComponent({super.key, this.items, this.showItems});

  @override
  Widget build(BuildContext context) {
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
                          const Align(
                            alignment: Alignment.topRight,
                            child: Icon(Icons.speaker_notes),
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
