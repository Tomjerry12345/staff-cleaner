import 'package:flutter/material.dart';

class ButtonElevatedComponent extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  const ButtonElevatedComponent(this.title, {super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.all(16),
        minimumSize: const Size(120, 40),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
      onPressed: onPressed,
      child: Text(title),
    );
  }
}
