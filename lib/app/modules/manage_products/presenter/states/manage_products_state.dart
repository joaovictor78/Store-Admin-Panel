import '../../domain/entities/product.dart';

abstract class ManageProductsState {}

class NoProductsAvailableManageProductsState implements ManageProductsState {}

class LoadingManageProductsState implements ManageProductsState {}

class ResultManageProductsState implements ManageProductsState {
  final List<Product> products;
  ResultManageProductsState(this.products);
}

class ExceptionManageProductsState implements ManageProductsState {
  final String message;

  ExceptionManageProductsState(this.message);
}
