
import 'package:flutter/material.dart';
import 'package:staff_cleaner/values/global_utils.dart';

extension ScreenConfig on double {
  double get h => (MediaQuery.of(ctx).size.height) * this;
  double get w => MediaQuery.of(ctx).size.width * this;
}