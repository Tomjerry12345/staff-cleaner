import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../component/text/text_component.dart';
import '../../../../values/font_custom.dart';
import '../../../../values/widget_utils.dart';

class SectionDataProfile extends StatelessWidget {
  final IconData icon;
  final String data;
  const SectionDataProfile(
    this.icon,
    this.data, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 32,
        ),
        H(32),
        TextComponent(
          data,
          size: 18,
          weight: Lato.Light,
        ),
      ],
    );
  }
}
