import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

stopLoaderDialog(BuildContext context) {
  Navigator.of(context, rootNavigator: true).pop();
}
