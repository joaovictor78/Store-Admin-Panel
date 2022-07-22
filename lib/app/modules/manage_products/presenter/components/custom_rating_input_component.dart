import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

// ignore: use_key_in_widget_constructors, must_be_immutable
class CustomRatingInputComponent extends StatefulWidget {
  void Function(double) onRatingUpdate;
  // ignore: use_key_in_widget_constructors
  CustomRatingInputComponent({required this.onRatingUpdate});
  @override
  State<CustomRatingInputComponent> createState() =>
      _CustomRatingInputComponentState();
}

class _CustomRatingInputComponentState
    extends State<CustomRatingInputComponent> {
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
          const Icon(LineIcons.star),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 3, left: 10),
                  child: Text(
                    "Avaliação do Produto",
                    style: GoogleFonts.inter(color: Colors.black, fontSize: 12),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    alignment: Alignment.topCenter,
                    child: RatingBar.builder(
                        initialRating: 3,
                        minRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemSize: 30,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                        updateOnDrag: true,
                        onRatingUpdate: widget.onRatingUpdate))
              ],
            ),
          )
        ],
      ),
    );
  }
}
