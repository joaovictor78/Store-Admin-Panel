import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:store_admin_panel/app/modules/manage_products/domain/entities/product.dart';
import 'package:store_admin_panel/app/modules/manage_products/domain/usecases/update_product.dart';
import 'package:store_admin_panel/app/modules/manage_products/domain/value_objects/product_image_vo.dart';

import '../../../../../mocks/mocks.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(ProductDTOFake());
    registerFallbackValue(ProductFake());
  });
  group('Update Product Use Case |', () {
    test('should update image product', () async {
      final repository = ManageProductsRepositoryMock();
      /*
      when(() => repository.updateImageProduct(dummyProductDTO.id,
              dummyProductDTO.productImageData.imagePath ?? ''))
          .thenAnswer((_) async => Right(dummyProduct.productImage));
          */
      when(() =>
              repository.updateProduct(any(), product: any(named: 'product')))
          .thenAnswer((_) async => Right(ProductFake()));

      final usecase = UpdateProduct(repository);
      final result = await usecase.call("", ProductDTOFake());
    });
  });
}
