import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../design_system/utils/sizes.dart';
import '../models/products_model.dart';

// ignore: must_be_immutable
class PreViewProductCardComponent extends StatefulWidget {
  void Function()? onEditImage;
  ProductModel? productModel;
  // ignore: use_key_in_widget_constructors
  PreViewProductCardComponent({this.onEditImage, this.productModel});

  @override
  State<PreViewProductCardComponent> createState() =>
      _ProductEditableCardComponentState();
}

class _ProductEditableCardComponentState
    extends State<PreViewProductCardComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
              child: Stack(
            children: [
              Container(
                  width: double.infinity,
                  height: widget.productModel?.image?.path == "" ? 80 : null,
                  margin: const EdgeInsets.only(
                      top: 15, left: 10, bottom: 10, right: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade200),
                  alignment: Alignment.topCenter,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        widget.productModel?.image ?? File(""),
                        fit: BoxFit.fitHeight,
                        errorBuilder: (_, __, ___) {
                          return Container();
                        },
                      ))),
              Positioned(
                  bottom: 5,
                  right: -0.5,
                  child: InkWell(
                    onTap: widget.onEditImage,
                    child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.black,
                              width: 2.0,
                            )),
                        child: CircleAvatar(
                            radius: 11,
                            backgroundColor: Colors.white,
                            child: Container(
                              color: Colors.white,
                              child: const Icon(
                                Icons.edit,
                                color: Colors.black,
                                size: 15,
                              ),
                            ))),
                  ))
            ],
          )),
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(top: 15, left: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.productModel?.name == null ||
                              widget.productModel?.name == ""
                          ? "Nome do Produto"
                          : widget.productModel!.name,
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
                            text: widget.productModel?.type == null ||
                                    widget.productModel?.type == ""
                                ? ""
                                : widget.productModel?.type,
                            style: GoogleFonts.inter(
                                color: Colors.black54,
                                fontWeight: FontWeight.normal),
                          )
                        ])),
                    RichText(
                        text: TextSpan(
                            style: GoogleFonts.inter(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                            text: "Descrição: ",
                            children: [
                          TextSpan(
                              text: widget.productModel?.description ?? "",
                              style: GoogleFonts.inter(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.normal))
                        ])),
                    Text(
                      "R\$ ${widget.productModel?.price ?? 0.00}",
                      style: GoogleFonts.inter(
                          color: Colors.black, fontWeight: FontWeight.w700),
                    ),
                    Container(
                      height: 15,
                      margin: const EdgeInsets.only(bottom: 15),
                      child: RatingBarIndicator(
                        itemCount: 5,
                        itemSize: 20,
                        rating: widget.productModel?.rating ?? 3,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
