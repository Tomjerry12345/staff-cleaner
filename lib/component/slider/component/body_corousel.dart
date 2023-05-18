import 'package:flutter/material.dart';

import '../../../values/font_custom.dart';
import '../../../values/widget_utils.dart';
import '../../text/text_component.dart';

class BodyCorousel extends StatelessWidget {
  final String title, data;
  const BodyCorousel(this.title, this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextComponent(title, size: 18),
        V(8),
        TextComponent(data, weight: Lato.Light, size: 14),
        V(16)
      ],
    );
  }
}
