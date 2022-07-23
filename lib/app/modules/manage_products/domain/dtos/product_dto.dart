import '../entities/product.dart';
import '../value_objects/product_image_vo.dart';

class ProductDTO {
  String id;
  ProductImageVO productImageData;
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
      ProductImageVO? productImageData})
      : productImageData = productImageData ?? ProductImageVO();

  Product convertToProduct() {
    return Product(
        id: id,
        title: title,
        type: type,
        productImage: productImageData,
        description: description,
        rating: rating,
        price: price);
  }

  static Product fromMap(Map<String, dynamic> map) {
    return Product(
        id: map['id'],
        productImage:
            ProductImageVO(name: map['filename'], imagePath: map['image_path']),
        title: map['title'],
        type: map['type'],
        description: map['description'],
        price: map['price'],
        rating: map['rating'] * 1.0);
  }

  static Map<String, dynamic> toMap(Product product) {
    Map<String, dynamic> data = {
      'title': product.title,
      'type': product.type,
      'description': product.description,
      'price': product.price,
      'rating': product.rating,
      'filename': product.productImage.name,
    };
    return data;
  }
}
