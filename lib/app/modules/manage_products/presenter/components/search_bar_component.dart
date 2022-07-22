import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class SearchBarComponent extends StatefulWidget {
  void Function(String) onChanged;
  // ignore: use_key_in_widget_constructors
  SearchBarComponent({required this.onChanged});

  @override
  State<SearchBarComponent> createState() => _SearchBarComponentState();
}

class _SearchBarComponentState extends State<SearchBarComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 25),
      child: TextField(
        style: GoogleFonts.rubik(color: Colors.black),
        onChanged: widget.onChanged,
        autofocus: false,
        decoration: InputDecoration(
            hintText: "Busque por um produto...",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18.0),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.white,
            filled: true,
            hintStyle: GoogleFonts.rubik(color: Colors.black, fontSize: 13),
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.black,
            )),
      ),
    );
  }
}
