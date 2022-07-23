import 'package:dartz/dartz.dart';
import '../../../../../core/erros/general_failures.dart';
import '../../dtos/product_dto.dart';
import '../../entities/product.dart';
import '../../value_objects/product_image_vo.dart';

abstract class IManageProductsRepository {
  Future<Either<Failure, List<Product>>> getProducts({String filter = ""});
  Future<Either<Failure, Product>> createProduct({required ProductDTO product});
  Future<Either<Failure, ProductImageVO>> uploadImageProduct(String imagePath);
  Future<Either<Failure, ProductImageVO>> updateImageProduct(
      String id, String imagePath);
  Future<Either<Failure, Product>> updateProduct(String id,
      {required Product product});
  Future<Either<Failure, bool>> removeProduct(String id);
}
