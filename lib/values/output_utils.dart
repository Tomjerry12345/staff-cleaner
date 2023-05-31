import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:staff_cleaner/component/button/button_component.dart';
import 'package:staff_cleaner/values/widget_utils.dart';

import '../component/text/text_component.dart';
import '../component/textfield/textfield_component.dart';
import 'global_utils.dart';

void showToast(msg) {
  Fluttertoast.showToast(
      msg: "$msg",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

void logO(t, {dynamic m = ""}) {
  m == "" ? print("[d] $t") : print("[d] $t: $m");
}

Future dialogList(
    {String title = "",
    required List<Map<String, dynamic>> item,
    required Function(Map) onGetItem}) {
  return showDialog(
      context: ctx,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Container(
            height: 250.0, // Change as per your requirement
            width: 300.0, // Change as per your requirement
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: item.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(item[index]["title"]),
                  onTap: () {
                    Navigator.of(ctx).pop();
                    onGetItem(item[index]);
                  },
                );
              },
            ),
          ),
        );
      });
}

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Row(
      children: [
        const CircularProgressIndicator(),
        Container(margin: const EdgeInsets.only(left: 7), child: const Text("Loading...")),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showDialogNoSurat(BuildContext context, controller, controller1, onPressed) {
  AlertDialog alert = AlertDialog(
    content: Container(
      height: 120,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // const CircularProgressIndicator(),
          // Container(margin: const EdgeInsets.only(left: 7), child: const Text("Loading...")),
          Row(
            children: [
              Container(
                width: 60,
                height: 50,
                child: TextField(controller: controller, keyboardType: TextInputType.number),
              ),
              H(16),
              TextComponent("/INV", size: 16),
              TextComponent("/YBS/", size: 16),
              H(16),
              Container(
                width: 60,
                height: 50,
                child: TextField(
                  controller: controller1,
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          V(16),
          ButtonElevatedComponent("Ok", onPressed: () {
            Navigator.of(context).pop();
            onPressed();
          })
        ],
      ),
    ),
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

closeDialog(BuildContext context) {
  Navigator.of(context, rootNavigator: true).pop();
}
