import 'package:mocktail/mocktail.dart';
import 'package:store_admin_panel/app/modules/manage_products/domain/dtos/product_dto.dart';
import 'package:store_admin_panel/app/modules/manage_products/domain/usecases/create_product.dart';
import 'package:store_admin_panel/app/modules/manage_products/domain/usecases/get_products.dart';
import 'package:store_admin_panel/app/modules/manage_products/domain/usecases/remove_product.dart';
import 'package:store_admin_panel/app/modules/manage_products/infra/interfaces/manage_products_datasource.dart';
import 'package:store_admin_panel/app/modules/manage_products/infra/repositories/manage_products_repository.dart';

class ManageProductsRepositoryMock extends Mock
    implements ManageProductsRepository {}

class ManageProductsDataSourceFirestoreMock extends Mock
    implements IManageProductsDataSource {}

class GetProductsMock extends Mock implements GetProducts {}

class CreateProductMock extends Mock implements CreateProduct {}

class RemoveProductMock extends Mock implements RemoveProduct {}
