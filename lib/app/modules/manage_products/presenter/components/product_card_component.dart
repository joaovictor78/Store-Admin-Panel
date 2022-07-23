import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import '../../../../design_system/utils/sizes.dart';
import '../../domain/entities/product.dart';

// ignore: must_be_immutable
class ProductCardComponent extends StatefulWidget {
  Product product;
  void Function()? onPressedSettings;
  // ignore: use_key_in_widget_constructors
  ProductCardComponent(
      {required this.product, required this.onPressedSettings});

  @override
  State<ProductCardComponent> createState() => _ProductCardComponentState();
}

class _ProductCardComponentState extends State<ProductCardComponent> {
  String imageUrl = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            offset: const Offset(0.0, 0.0), //(x,y)
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Container(
                  width: 200,
                  height: 200,
                  padding: const EdgeInsets.only(top: 15, left: 10, bottom: 10),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  alignment: Alignment.topCenter,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: widget.product.productImage.imagePath!,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder: (_, __, ___) {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: Colors.black,
                        ));
                      },
                    ),
                  ))),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(top: 15, left: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.title,
                  style: GoogleFonts.inter(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 14),
                ),
                SizedBox(
                  height: Sizes.dp10(context) * 0.5,
                ),
                RichText(
                    text: TextSpan(
                        style: GoogleFonts.inter(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 13),
                        text: "Tipo: ",
                        children: [
                      TextSpan(
                        text: widget.product.type,
                        style: GoogleFonts.inter(
                            color: Colors.black54,
                            fontWeight: FontWeight.normal),
                      )
                    ])),
                Flexible(
                  child: RichText(
                      text: TextSpan(
                          style: GoogleFonts.inter(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                          text: "Descrição: ",
                          children: [
                        TextSpan(
                            text: widget.product.description,
                            style: GoogleFonts.inter(
                                color: Colors.black54,
                                fontWeight: FontWeight.normal))
                      ])),
                ),
                Container(
                  height: 15,
                  margin: const EdgeInsets.only(bottom: 15),
                  child: RatingBarIndicator(
                    itemCount: 5,
                    itemSize: 20,
                    rating: widget.product.rating.toDouble(),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                  ),
                )
              ],
            ),
          )),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(right: 15, top: 15, bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: widget.onPressedSettings,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      minimumSize: const Size(10, 30),
                    ),
                    child: const Icon(
                      LineIcons.verticalEllipsis,
                      color: Colors.black,
                      size: 30,
                    )),
                const Spacer(),
                Text(
                  "R\$ ${widget.product.price}",
                  style: GoogleFonts.inter(
                      color: Colors.black, fontWeight: FontWeight.w700),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
