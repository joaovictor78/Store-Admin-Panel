import '../value_objects/product_image_vo.dart';

class Product {
  String id;
  ProductImageVO productImage;
  String title;
  String type;
  String description;
  double rating;
  double price;
  Product(
      {this.id = "",
      ProductImageVO? productImage,
      this.title = "",
      this.type = "",
      this.description = "",
      this.rating = 0,
      this.price = 0.0})
      : productImage = productImage ?? ProductImageVO();
}
