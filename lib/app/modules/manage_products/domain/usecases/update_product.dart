import 'package:dartz/dartz.dart';
import '../../../../core/erros/general_failures.dart';
import '../dtos/product_dto.dart';
import '../entities/product.dart';
import '../errors/failures.dart';
import 'interfaces/manage_products_repository.dart';

class UpdateProduct {
  final IManageProductsRepository _repository;
  UpdateProduct(this._repository);

  Future<Either<Failure, Product>> call(
      String productId, ProductDTO product) async {
    if (!product.productImageData.imagePath!.contains('https://')) {
      final productImageDataOrFailure = await _repository.updateImageProduct(
          productId, product.productImageData.imagePath!);
      if (productImageDataOrFailure.isLeft()) {
        return Left(FailureToUpdateProductImage(
            message: "Ocorreu uma falha ao fazer o upload da imagem"));
      }
      productImageDataOrFailure.map((r) => product.productImageData = r);
    }
    final productOrFailure = await _repository.updateProduct(productId,
        product: product.convertToProduct());

    return productOrFailure;
  }
}
