import 'package:flutter/material.dart';

class TextfieldDateComponent extends StatefulWidget {
  final String hintText;
  final Function(String)? onChanged;
  final TextEditingController? controller;

  const TextfieldDateComponent({super.key, this.hintText = "", this.onChanged, this.controller});

  @override
  State<TextfieldDateComponent> createState() => _TextfieldDateComponentState();
}

class _TextfieldDateComponentState extends State<TextfieldDateComponent> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: widget.onChanged,
      controller: widget.controller,
      cursorColor: Colors.black,
      decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(
              Icons.date_range,
              color: Theme.of(context).primaryColorDark,
            ),
            onPressed: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2099),
              ).then((date) {
                //tambahkan setState dan panggil variabel _dateTime.
                setState(() {
                  widget.controller?.text = "${date?.day}/${date?.month}/${date?.year}";
                });
              });
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          hintStyle: TextStyle(color: Colors.grey[800]),
          hintText: widget.hintText,
          fillColor: Colors.white70),
    );
  }
}
