import 'package:dartz/dartz.dart';
import '../../../../core/erros/general_failures.dart';
import 'interfaces/manage_products_repository.dart';

class RemoveProduct {
  final IManageProductsRepository _repository;

  RemoveProduct(this._repository);

  Future<Either<Failure, bool>> call(String id) async {
    final response = await _repository.removeProduct(id);
    return response;
  }
}
