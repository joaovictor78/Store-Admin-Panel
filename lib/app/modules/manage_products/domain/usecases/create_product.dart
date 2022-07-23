import 'package:dartz/dartz.dart';
import '../../../../core/erros/general_failures.dart';
import '../dtos/product_dto.dart';
import '../entities/product.dart';
import '../errors/failures.dart';
import 'interfaces/manage_products_repository.dart';

class CreateProduct {
  final IManageProductsRepository _repository;
  CreateProduct(this._repository);
  Future<Either<Failure, Product>> call(ProductDTO product) async {
    final productImageDataOrFailure = await _repository
        .uploadImageProduct(product.productImageData.imagePath!);
    if (productImageDataOrFailure.isLeft()) {
      return Left(FailureToUploadProductImage(message: ""));
    }
    productImageDataOrFailure.map((r) => product.productImageData = r);
    final newProductOrFailure =
        await _repository.createProduct(product: product);
    if (newProductOrFailure.isRight()) {
      newProductOrFailure
          .map((product) => productImageDataOrFailure.map((productImageData) {
                product.productImage = productImageData;
              }));
    }
    return newProductOrFailure;
  }
}
