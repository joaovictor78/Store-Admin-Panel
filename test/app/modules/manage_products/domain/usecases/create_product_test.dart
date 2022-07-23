import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:store_admin_panel/app/modules/manage_products/domain/dtos/product_dto.dart';
import 'package:store_admin_panel/app/modules/manage_products/domain/entities/product.dart';
import 'package:store_admin_panel/app/modules/manage_products/domain/usecases/create_product.dart';
import 'package:store_admin_panel/app/modules/manage_products/domain/value_objects/product_image_vo.dart';
import '../../../../../mocks/mocks.dart';

void main() {
  late ProductDTO dummyProduct;

  setUpAll(() {
    dummyProduct = ProductDTO(
        productImageData:
            ProductImageVO(imagePath: 'test_resources/assets/0.jpg'));
  });

  group('Create Product Use Case |', () {
    test('should return new product if create successfully', () async {
      final repository = ManageProductsRepositoryMock();
      when(() => repository
              .uploadImageProduct(dummyProduct.productImageData.imagePath!))
          .thenAnswer((_) async => Right(ProductImageVO(
              imagePath: 'https://fakehost.com.br', name: 'fake.jpg')));
      when(() => repository.createProduct(product: dummyProduct)).thenAnswer(
          (_) async => Right(Product(
              id: '',
              description: '',
              productImage: ProductImageVO(
                  imagePath: 'https://fakehost.com.br', name: 'fake.jpg'),
              price: 0.0,
              rating: 0,
              title: '',
              type: '')));
      final usecase = CreateProduct(repository);
      final response = await usecase.call(dummyProduct);
      response.fold((l) => null, (r) {
        expect(r.productImage.imagePath, contains('https://fakehost.com.br'));
        expect(r.productImage.name, equals('fake.jpg'));
      });
    });
  });
}
