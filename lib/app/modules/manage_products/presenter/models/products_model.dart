import '../../domain/dtos/product_dto.dart';
import '../../domain/entities/product.dart';
import '../../domain/value_objects/product_image_vo.dart';

class ProductModel {
  ProductImageVO? productImageData;
  String name;
  String description;
  String type;
  double price;
  double rating;
  ProductModel(
      {this.productImageData,
      this.name = "",
      this.price = 0,
      this.description = "",
      this.rating = 3,
      this.type = ""});

  ProductModel copyWith(
      {ProductImageVO? productImageData,
      String? name,
      String? type,
      String? description,
      double? price,
      double? rating}) {
    return ProductModel(
        productImageData: productImageData ?? this.productImageData,
        name: name ?? this.name,
        price: price ?? this.price,
        description: description ?? this.description,
        rating: rating ?? this.rating,
        type: type ?? this.type);
  }

  factory ProductModel.from(Product product) {
    return ProductModel(
        productImageData: product.productImage,
        description: product.description,
        name: product.title,
        price: product.price,
        rating: product.rating,
        type: product.type);
  }
  ProductDTO convertToDTO() {
    return ProductDTO(
        title: name,
        productImageData: productImageData!,
        description: description,
        rating: rating,
        price: price,
        type: type);
  }

  String verify() {
    if (productImageData?.imagePath == "") {
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
