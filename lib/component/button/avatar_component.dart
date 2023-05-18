import 'package:flutter/material.dart';

class AvatarComponent extends StatelessWidget {
  final String url;
  final IconData? icon;
  final double size;
  final AlignmentGeometry positionIcon;
  final double positionIconV;
  final double positionIconH;
  final double radiusIcon;
  final double sizeIcon;
  final Color colorIconBg;
  const AvatarComponent(this.url,
      {super.key,
      this.size = 60,
      this.icon,
      this.positionIcon = AlignmentDirectional.bottomEnd,
      this.positionIconV = 140,
      this.positionIconH = 120,
      this.radiusIcon = 16,
      this.sizeIcon = 50,
      this.colorIconBg = Colors.white});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: positionIconV,
      height: positionIconH,
      child: Stack(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(url),
            radius: size,
          ),
          icon != null
              ? Align(
                  alignment: positionIcon,
                  child: Material(
                    color: colorIconBg,
                    borderRadius: BorderRadius.circular(radiusIcon),
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(radiusIcon),
                      child: Container(
                        width: sizeIcon,
                        height: sizeIcon,
                        alignment: Alignment.center,
                        child: Icon(icon),
                      ),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
