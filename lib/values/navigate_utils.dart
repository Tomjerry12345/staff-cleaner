import 'package:flutter/material.dart';
import 'package:staff_cleaner/values/global_utils.dart';

navigatePush(page) {
  Navigator.push(
    ctx,
    MaterialPageRoute(builder: (context) => page),
  );
}

navigatePop() {
  Navigator.pop(ctx);
}

navigatePushAndRemove(page) {
  Navigator.pushAndRemoveUntil(
      ctx, MaterialPageRoute(builder: (context) => page), (Route route) => false);
}
