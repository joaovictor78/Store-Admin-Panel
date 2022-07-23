import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:store_admin_panel/app/core/erros/client_http_failures.dart';
import 'package:store_admin_panel/app/core/erros/general_failures.dart';
import 'package:store_admin_panel/app/modules/manage_products/domain/dtos/product_dto.dart';
import 'package:store_admin_panel/app/modules/manage_products/domain/entities/product.dart';
import 'package:store_admin_panel/app/modules/manage_products/domain/value_objects/product_image_vo.dart';
import 'package:store_admin_panel/app/modules/manage_products/infra/repositories/manage_products_repository.dart';
import '../../../../../mocks/mocks.dart';

void main() {
  group('Manage Products Repository: Get Products |', () {
    test('should return list products if is sucess', () async {
      final datasource = ManageProductsDataSourceFirestoreMock();
      when(() => datasource.getProducts())
          .thenAnswer((_) async => _fakeProducts);
      final repository = ManageProductsRepository(datasource);
      final response = await repository.getProducts(filter: "");
      response.fold((l) => expect(l, isNull), (r) {
        expect(r, isA<List<Product>>());
        expect(r[0].title, "Brown eggs");
      });
    });
    test('should throw exception if no internet connection', () async {
      final datasource = ManageProductsDataSourceFirestoreMock();
      when(() => datasource.getProducts()).thenThrow(
          NoInternetConection(message: "Não há conexão com a internet."));
      final repository = ManageProductsRepository(datasource);
      final response = await repository.getProducts(filter: "");
      response.fold((l) => expect(l, isA<NoInternetConection>()),
          (r) => expect(r, isNull));
    });
    test('should throw exception of type general failure', () async {
      final datasource = ManageProductsDataSourceFirestoreMock();
      when(() => datasource.getProducts()).thenThrow(
          GeneralFailure(message: "Ocorreu um erro ao pegar os produtos."));
      final repository = ManageProductsRepository(datasource);
      final response = await repository.getProducts(filter: "");
      response.fold(
          (l) => expect(l, isA<GeneralFailure>()), (r) => expect(r, isNull));
    });
  });

  group('Manage Products Repository: Create Product |', () {
    test(
        'should return the product if the data source is processed successfully',
        () async {
      final datasource = ManageProductsDataSourceFirestoreMock();
      final repository = ManageProductsRepository(datasource);

      when(() =>
              datasource.createProduct(Product(productImage: ProductImageVO())))
          .thenAnswer((_) async => Product(productImage: ProductImageVO()));

      final response = await repository.createProduct(
          product: ProductDTO(
              productImageData:
                  ProductImageVO(imagePath: "test_resources/assets/0.jpg")));
      response.fold((l) => null, (r) => expect(r, isA<Product>()));
    });
  });
  group('Manage Products Repository: Remove Product |', () {
    test("should return true ", () async {
      final datasource = ManageProductsDataSourceFirestoreMock();

      when(() => datasource.removeProduct(""))
          .thenAnswer((_) async => const Right(true));
      final repository = ManageProductsRepository(datasource);
      final response = await repository.removeProduct("");
      response.fold((l) => null, (r) => expect(r, true));
    });
    test("should return true if the product is successfully removed", () async {
      final datasource = ManageProductsDataSourceFirestoreMock();

      when(() => datasource.removeProduct(""))
          .thenAnswer((_) async => const Right(true));
      final repository = ManageProductsRepository(datasource);
      final response = await repository.removeProduct("");
      response.fold((l) => null, (r) => expect(r, true));
    });

    test('should throw exception if no internet connection', () async {
      final datasource = ManageProductsDataSourceFirestoreMock();
      when(() => datasource.getProducts()).thenThrow(
          NoInternetConection(message: "Não há conexão com a internet."));
      final repository = ManageProductsRepository(datasource);
      final response = await repository.removeProduct("");
      response.fold(
          (l) => expect(l, isA<GeneralFailure>()), (r) => expect(r, isNull));
    });
    test('should throw exception of type general failure', () async {
      final datasource = ManageProductsDataSourceFirestoreMock();
      when(() => datasource.getProducts()).thenThrow(
          GeneralFailure(message: "Ocorreu um erro ao remover o produto."));
      final repository = ManageProductsRepository(datasource);
      final response = await repository.removeProduct("");
      response.fold(
          (l) => expect(l, isA<GeneralFailure>()), (r) => expect(r, isNull));
    });
  });
}

List<Map<String, dynamic>> _fakeProducts = [
  {
    "title": "Brown eggs",
    "type": "dairy",
    "description": "Raw organic brown eggs in a basket",
    "filename": "0.jpg",
    "height": 600,
    "width": 400,
    "price": 28.1,
    "rating": 4
  },
  {
    "title": "Sweet fresh stawberry",
    "type": "fruit",
    "description": "Sweet fresh stawberry on the wooden table",
    "filename": "1.jpg",
    "height": 450,
    "width": 299,
    "price": 29.45,
    "rating": 4
  }
];
