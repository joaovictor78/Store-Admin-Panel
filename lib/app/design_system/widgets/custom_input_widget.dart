import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomInputWidget extends StatefulWidget {
  String hintText;
  String labelText;
  IconData icon;
  TextEditingController? controller;
  TextInputType? keyboardType;
  void Function(String)? onChanged;
  // ignore: use_key_in_widget_constructors
  CustomInputWidget(
      {this.hintText = "",
      this.labelText = "",
      this.icon = Icons.abc,
      this.keyboardType,
      this.onChanged,
      this.controller});

  @override
  State<CustomInputWidget> createState() => _CustomInputWidgetState();
}

class _CustomInputWidgetState extends State<CustomInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: widget.controller,
        onChanged: widget.onChanged,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10)),
          fillColor: const Color(0xFFF3F3F3),
          filled: true,
          hintStyle: GoogleFonts.inter(fontSize: 13),
          hintText: widget.hintText,
          prefixIcon: Icon(
            widget.icon,
            color: Colors.black,
          ),
          label: Container(
            color: Colors.white,
            child: Text(
              widget.labelText,
              style: GoogleFonts.inter(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
