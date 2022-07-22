import 'dart:io';

import '../../domain/dtos/product_dto.dart';

class ProductModel {
  File? image;
  String name;
  String description;
  String type;
  double price;
  double rating;
  ProductModel(
      {this.image,
      this.name = "",
      this.price = 0,
      this.description = "",
      this.rating = 3,
      this.type = ""});

  ProductModel copyWith(
      {File? image,
      String? name,
      String? type,
      String? description,
      double? price,
      double? ratting}) {
    return ProductModel(
        image: image ?? this.image,
        name: name ?? this.name,
        price: price ?? this.price,
        description: description ?? this.description,
        rating: ratting ?? this.rating,
        type: type ?? this.type);
  }

  ProductDTO convertToDTO() {
    return ProductDTO(
        imageFile: image!,
        description: description,
        rating: rating,
        price: price,
        type: type);
  }

  String verify() {
    if (image?.path == "") {
      return "A imagem não pode está vazia";
    } else if (name == "") {
      return "O nome não pode ser nulo";
    } else if (type == "") {
      return "O tipo não pode está vazio";
    } else if (description == "") {
      return "A descrição não pode está vazia";
    } else if (price == 0) {
      return "O preço não pode ser 0";
    } else {
      return "";
    }
  }
}
