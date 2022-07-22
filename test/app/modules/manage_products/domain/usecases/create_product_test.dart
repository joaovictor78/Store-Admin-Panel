import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:store_admin_panel/app/modules/manage_products/domain/dtos/product_dto.dart';
import 'package:store_admin_panel/app/modules/manage_products/domain/entities/product.dart';
import 'package:store_admin_panel/app/modules/manage_products/domain/usecases/create_product.dart';
import '../../../../../mocks/mocks.dart';

void main() {
  late ProductDTO dummyProduct;

  setUpAll(() {
    dummyProduct = ProductDTO(imageFile: File('test_resources/assets/0.jpg'));
  });

  group('Create Product Use Case |', () {
    test('should return new product if create successfully', () async {
      final repository = ManageProductsRepositoryMock();
      when(() => repository.uploadImageProduct(dummyProduct.imageFile))
          .thenAnswer((_) async => const Right('https://fakehost.com.br'));
      when(() => repository.createProduct(product: dummyProduct)).thenAnswer(
          (_) async => Right(Product(
              id: '',
              description: '',
              pathImage: 'https://fakehost.com.br',
              price: 0.0,
              rating: 0,
              title: '',
              type: '')));
      final usecase = CreateProduct(repository);
      final response = await usecase.call(dummyProduct);
      response.fold((l) => null,
          (r) => expect(r.pathImage, contains('https://fakehost.com.br')));
    });
  });
}
