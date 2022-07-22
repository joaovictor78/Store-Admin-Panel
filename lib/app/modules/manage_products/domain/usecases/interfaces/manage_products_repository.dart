import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../../../../core/erros/general_failures.dart';
import '../../dtos/product_dto.dart';
import '../../entities/product.dart';

abstract class IManageProductsRepository {
  Future<Either<Failure, List<Product>>> getProducts({String filter = ""});
  Future<Either<Failure, Product>> createProduct({required ProductDTO product});
  Future<Either<Failure, String>> uploadImageProduct(File image);
  Future<Either<Failure, bool>> updateProduct();
  Future<Either<Failure, bool>> removeProduct(String id);
}
