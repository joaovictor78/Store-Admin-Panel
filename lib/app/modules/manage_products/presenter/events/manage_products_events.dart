import '../../domain/dtos/product_dto.dart';

abstract class ManageProductsEvent {}

class FetchProductsEvent implements ManageProductsEvent {
  final String filterTerm;
  FetchProductsEvent({this.filterTerm = ""});
}

class RemoveProductEvent implements ManageProductsEvent {
  final String id;
  RemoveProductEvent({required this.id});
}

class CreateProductEvent implements ManageProductsEvent {
  final ProductDTO product;
  CreateProductEvent(this.product);
}

class UpdateProductEvent implements ManageProductsEvent {
  final ProductDTO product;
  UpdateProductEvent(this.product);
}
