import 'package:dartz/dartz.dart';
import '../../../../core/erros/general_failures.dart';
import '../entities/product.dart';
import 'interfaces/manage_products_repository.dart';

class GetProducts {
  final IManageProductsRepository _repository;
  GetProducts(this._repository);

  Future<Either<Failure, List<Product>>> call(
    String filter,
  ) async {
    final response = await _repository.getProducts(filter: filter);
    return response;
  }
}
