import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:staff_cleaner/values/screen_utils.dart';

import '../../../../../component/button/button_component.dart';
import '../../../../../component/text/text_component.dart';
import '../../../../../component/textfield/textfield_component.dart';
import '../../../../../component/textfield/textfield_date_component.dart';
import '../../../../../component/textfield/textfield_dropdown_component .dart';
import '../../../../../services/firebase_services.dart';
import '../../../../../values/color.dart';
import '../../../../../values/constant.dart';
import '../../../../../values/font_custom.dart';
import '../../../../../values/navigate_utils.dart';
import '../../../../../values/output_utils.dart';
import '../../../../../values/widget_utils.dart';
import '../../../admin_main.dart';

class DetailJadwalCustomer extends StatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> item;
  const DetailJadwalCustomer({super.key, required this.item});

  @override
  State<DetailJadwalCustomer> createState() => _DetailJadwalCustomerState();
}

class _DetailJadwalCustomerState extends State<DetailJadwalCustomer> {
  final namaLengkapController = TextEditingController();
  final tanggalLahirController = TextEditingController();
  final noHpController = TextEditingController();
  final staffController = SingleValueDropDownController();
  final tanggalLayananController = TextEditingController();
  final jamLayananController = TextEditingController();
  final dayaController = TextEditingController();
  final mengetahuiController = TextEditingController();
  final alamatLengkapController = TextEditingController();
  final latController = TextEditingController();
  final longController = TextEditingController();

  List<dynamic> itemYangDibersihkan = [];
  List<Map<dynamic, dynamic>> listUser = [];

  final fs = FirebaseServices();

  void getListUser() async {
    try {
      final res = await fs.getDataCollectionByQuery("staff", "bertugas", false);
      if (res.isNotEmpty) {
        List<Map<dynamic, dynamic>> user = [];
        for (var e in res) {
          user.add(e.data());
        }
        setState(() {
          listUser = user;
        });
      }
    } catch (e) {
      logO("getListUser", m: e.toString());
    }
  }

  void addItemYangDibersihkan(Map item) {
    itemYangDibersihkan.add(item);
  }

  void removeItemYangDibersihkan(Map item) {
    itemYangDibersihkan.remove(item);
  }

  void uploadData(data, String id, email) async {
    try {
      logO("id", m: id);
      await fs.updateDataAllDoc("data", id, data);
      fs.updateDataCollectionByTwoQuery("staff", "email", email, "bertugas", true);
      navigatePushAndRemove(const AdminMain());
    } catch (e) {
      logO("error", m: e);
    }
  }

  void deleteData(String id, email) async {
    try {
      logO("id", m: id);
      await fs.deleteDoc("data", id);
      fs.updateDataCollectionByTwoQuery("staff", "email", email, "bertugas", false);
      navigatePushAndRemove(const AdminMain());
    } catch (e) {
      logO("error", m: e);
    }
  }

  @override
  void initState() {
    super.initState();

    namaLengkapController.text = widget.item["nama_lengkap"];
    tanggalLahirController.text = widget.item["tanggal_lahir"];
    noHpController.text = widget.item["no_hp"];
    staffController.dropDownValue =
        DropDownValueModel(name: widget.item["nama_staff"], value: widget.item["email_staff"]);
    tanggalLayananController.text = widget.item["tanggal_layanan"];
    jamLayananController.text = widget.item["jam_layanan"];
    dayaController.text = widget.item["daya"];
    mengetahuiController.text = widget.item["mengetahui"];
    alamatLengkapController.text = widget.item["alamat_lengkap"];
    latController.text = widget.item["lokasi"]["latitude"];
    longController.text = widget.item["lokasi"]["longitude"];

    getListUser();

    setState(() {
      itemYangDibersihkan = widget.item["item_yang_dibersihkan"] as List<dynamic>;
    });
  }

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
                "Edit Data",
                color: Colors.white,
              ),
              V(32),
              TextfieldComponent(
                hintText: "Nama lengkap...",
                onChanged: (value) {},
                color: Colors.white,
                controller: namaLengkapController,
              ),
              V(16),
              TextfieldDateComponent(
                  hintText: "Tanggal lahir...",
                  onChanged: (value) {},
                  controller: tanggalLahirController,
                  color: Colors.white),
              V(16),
              TextfieldComponent(
                hintText: "No. handphone...",
                onChanged: (value) {},
                color: Colors.white,
                controller: noHpController,
                inputType: TextInputType.phone,
              ),
              V(16),
              TextfieldDropdownComponent(
                hintText: "Staff yang melayani...",
                onChanged: (value) {},
                items:
                    listUser.map((e) => {"name": e["nama_lengkap"], "value": e["email"]}).toList(),
                controller: staffController,
              ),
              V(16),
              TextfieldDateComponent(
                  hintText: "Tanggal layanan...",
                  onChanged: (value) {},
                  controller: tanggalLayananController,
                  color: Colors.white),
              V(16),
              TextfieldDateComponent(
                hintText: "Jam layanan...",
                onChanged: (value) {},
                controller: jamLayananController,
                color: Colors.white,
                type: "time",
              ),
              V(16),
              const TextComponent(
                "Item yang akan di bersihkan: ",
                size: 18,
                color: Colors.white,
              ),
              V(8),
              Column(
                  children: itemYangDibersihkan
                      .asMap()
                      .map((i, e) => MapEntry(
                          i,
                          Stack(
                            children: [
                              Column(
                                children: [
                                  Card(
                                    elevation: 8,
                                    clipBehavior: Clip.hardEdge,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextComponent(
                                            "${i + 1}. [${e["service"]}] ${e["item"]}",
                                            size: 11,
                                            weight: Lato.Light,
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  removeItemYangDibersihkan(itemYangDibersihkan[i]);
                                                });
                                              },
                                              icon: Icon(Icons.remove))
                                        ],
                                      ),
                                    ),
                                  ),
                                  V(8)
                                ],
                              )
                            ],
                          )))
                      .values
                      .toList()),
              V(8),
              Center(
                child: ButtonElevatedComponent(
                  "Tambah item",
                  onPressed: () {
                    return dialogList(
                        title: "Services",
                        item: listItemLayanan,
                        onGetItem: (service) {
                          logO("service", m: service);

                          String title = service["title"];
                          List<Map<String, dynamic>> itemYangDibersihkan =
                              listItemDibershikan[title]!;

                          return dialogList(
                              title: "Item",
                              item: itemYangDibersihkan,
                              onGetItem: (item) {
                                setState(() {
                                  addItemYangDibersihkan({
                                    "service": title,
                                    "item": item["title"],
                                    "harga": item["harga"]
                                  });
                                });

                                logO("item", m: item);
                              });
                        });
                  },
                ),
              ),
              V(24),
              TextfieldComponent(
                hintText: "Daya...",
                onChanged: (value) {},
                color: Colors.white,
                controller: dayaController,
                inputType: TextInputType.number,
              ),
              V(16),
              TextfieldComponent(
                hintText: "Mengetahui yuk bersihin dari ?...",
                onChanged: (value) {},
                color: Colors.white,
                controller: mengetahuiController,
              ),
              V(16),
              TextfieldComponent(
                hintText: "Alamat lengkap...",
                onChanged: (value) {},
                color: Colors.white,
                controller: alamatLengkapController,
              ),
              V(32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 0.4.w,
                    child: TextfieldComponent(
                      hintText: "Latitude...",
                      onChanged: (value) {},
                      color: Colors.white,
                      controller: latController,
                      inputType: TextInputType.streetAddress,
                    ),
                  ),
                  SizedBox(
                    width: 0.4.w,
                    child: TextfieldComponent(
                        hintText: "Longitude...",
                        onChanged: (value) {},
                        color: Colors.white,
                        controller: longController,
                        inputType: TextInputType.streetAddress),
                  ),
                ],
              ),
              V(32),
              Center(
                child: ButtonElevatedComponent(
                  "Edit Data",
                  onPressed: () {
                    final user = fs.getUser();
                    final data = {
                      "email": user?.email,
                      "selesai": false,
                      "nama_lengkap": namaLengkapController.text,
                      "tanggal_lahir": tanggalLahirController.text,
                      "no_hp": noHpController.text,
                      "nama_staff": staffController.dropDownValue?.name,
                      "email_staff": staffController.dropDownValue?.value,
                      "tanggal_layanan": tanggalLayananController.text,
                      "jam_layanan": jamLayananController.text,
                      "item_yang_dibersihkan": itemYangDibersihkan,
                      "daya": dayaController.text,
                      "mengetahui": mengetahuiController.text,
                      "alamat_lengkap": alamatLengkapController.text,
                      "lokasi": {"latitude": latController.text, "longitude": longController.text},
                    };

                    uploadData(data, widget.item.id, staffController.dropDownValue?.value);
                  },
                ),
              ),
              V(24),
              Center(
                child: ButtonElevatedComponent(
                  "Delete Data",
                  onPressed: () {
                    deleteData(widget.item.id, widget.item["email_staff"]);
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
