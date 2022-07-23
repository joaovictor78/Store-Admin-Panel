import '../../domain/entities/product.dart';

abstract class IManageProductsDataSource {
  Future<Product> createProduct(Product product);
  Future<Map<String, dynamic>> uploadImage(String imagePath);
  Future<Map<String, dynamic>> updateImage(String id, String imagePath);
  Future<List<Map<String, dynamic>>> getProducts({String filter = ""});
  Future<Map<String, dynamic>> updateProduct(String id, Product product);
  Future<void> removeProduct(String id);
}
