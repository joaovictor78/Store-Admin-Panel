import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../styles/color_palettes.dart';
import '../utils/sizes.dart';

// ignore: must_be_immutable
class CustomDialogWidget extends StatelessWidget {
  String tag;
  String description;
  String confirmedButtonDescription;
  String cancelButtonDescription;
  void Function()? onConfirmed;
  void Function()? onCanceled;

  // ignore: use_key_in_widget_constructors
  CustomDialogWidget(
      {this.tag = "",
      this.description = "",
      this.confirmedButtonDescription = "",
      this.cancelButtonDescription = "",
      this.onConfirmed,
      this.onCanceled});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 240,
        child: Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
            child: Column(
              children: [
                Text(
                  tag,
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500, fontSize: 16),
                ),
                SizedBox(
                  height: Sizes.dp13(context),
                ),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400, fontSize: 12),
                ),
                const Spacer(),
                TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: ColorPalettes.lightPrimary,
                      padding: const EdgeInsets.symmetric(horizontal: 80)),
                  onPressed: onConfirmed,
                  child: Text(confirmedButtonDescription,
                      style: GoogleFonts.inter(
                          color: Colors.white, fontWeight: FontWeight.w500)),
                ),
                TextButton(
                  onPressed: onCanceled,
                  child: Text(cancelButtonDescription,
                      style: GoogleFonts.inter(
                          color: ColorPalettes.lightPrimary,
                          fontWeight: FontWeight.w700)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
