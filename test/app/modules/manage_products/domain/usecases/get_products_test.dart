import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:store_admin_panel/app/modules/manage_products/domain/entities/product.dart';
import 'package:store_admin_panel/app/modules/manage_products/domain/usecases/get_products.dart';
import '../../../../../mocks/mocks.dart';

void main() {
  group('Get Products Use Case |', () {
    test("should return list product if is sucess", () async {
      final repository = ManageProductsRepositoryMock();
      when(() => repository.getProducts())
          .thenAnswer((_) => Future.value(const Right(<Product>[])));
      final usecase = await GetProducts(repository)("");
      usecase.fold((l) => null, (r) {
        expect(r, isA<List<Product>>());
      });
    });
  });
}
