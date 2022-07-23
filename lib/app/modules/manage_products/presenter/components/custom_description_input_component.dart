import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

// ignore: use_key_in_widget_constructors, must_be_immutable
class CustomDescriptionInputComponent extends StatefulWidget {
  void Function(String)? onChanged;
  String? initialValue;
  // ignore: use_key_in_widget_constructors
  CustomDescriptionInputComponent({this.onChanged, this.initialValue});
  @override
  State<CustomDescriptionInputComponent> createState() =>
      _CustomDescriptionInputComponentState();
}

class _CustomDescriptionInputComponentState
    extends State<CustomDescriptionInputComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFFF3F3F3)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(LineIcons.database),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 3, left: 10),
                  child: Text(
                    "Descrição",
                    style: GoogleFonts.inter(color: Colors.black, fontSize: 12),
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  initialValue: widget.initialValue,
                  maxLines: null,
                  onChanged: widget.onChanged,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: GoogleFonts.inter(fontSize: 13),
                      hintText: "Informe a descrição do produto"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
