import '../../domain/entities/product.dart';

class ProductMapper {
  static Product fromMap(Map<String, dynamic> map) {
    return Product(
        id: map['id'],
        pathImage: map['filename'],
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
      'filename': product.pathImage,
    };
    return data;
  }
}
