import 'dart:io';

import '../entities/product.dart';

class ProductDTO {
  String id;
  File imageFile;
  String title;
  String type;
  String description;
  double rating;
  double price;

  ProductDTO(
      {this.id = "",
      this.title = "",
      this.type = "",
      this.description = "",
      this.rating = 0,
      this.price = 0.0,
      required this.imageFile});

  Product convertToProduct() {
    return Product(
        id: id,
        title: title,
        type: type,
        description: description,
        rating: rating,
        price: price);
  }
}
