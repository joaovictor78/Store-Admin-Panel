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
    final urlOrFailure =
        await _repository.uploadImageProduct(product.imageFile);
    if (urlOrFailure.isLeft()) {
      return Left(FailureThenUploadProductImage(message: ""));
    }
    final newProductOrFailure =
        await _repository.createProduct(product: product);
    if (newProductOrFailure.isRight()) {
      newProductOrFailure
          .map((product) => urlOrFailure.map((url) => product.pathImage = url));
    }
    return newProductOrFailure;
  }
}
