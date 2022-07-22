import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:store_admin_panel/app/modules/manage_products/domain/usecases/remove_product.dart';
import '../../../../../mocks/mocks.dart';

void main() {
  test('should return true if product was removed ', () async {
    final repository = ManageProductsRepositoryMock();
    when(() => repository.removeProduct(""))
        .thenAnswer((_) async => const Right(true));
    final useCase = RemoveProduct(repository);
    final response = await useCase("");
    response.fold((l) => null, (r) => expect(r, true));
  });
}
