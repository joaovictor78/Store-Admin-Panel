import 'dart:io';
import '../../domain/entities/product.dart';

abstract class IManageProductsDataSource {
  Future<Product> createProduct(Product product);
  Future<String> uploadImage(File image);
  Future<List<Map<String, dynamic>>> getProducts({String filter = ""});
  Future<void> updateProduct();
  Future<void> removeProduct(String id);
}
