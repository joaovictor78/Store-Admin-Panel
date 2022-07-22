import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store_admin_panel/app/design_system/styles/color_palettes.dart';

// ignore: must_be_immutable
class CustomButtonWidget extends StatelessWidget {
  void Function()? onPressed;
  String title;
  // ignore: use_key_in_widget_constructors
  CustomButtonWidget({this.title = "", this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          minimumSize: const Size(double.infinity, 60),
          backgroundColor: ColorPalettes.lightPrimary,
        ),
        child: Text(
          title,
          style: GoogleFonts.inter(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
