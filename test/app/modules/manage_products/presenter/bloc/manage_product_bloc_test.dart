import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:store_admin_panel/app/core/erros/client_http_failures.dart';
import 'package:store_admin_panel/app/modules/manage_products/domain/dtos/product_dto.dart';
import 'package:store_admin_panel/app/modules/manage_products/domain/entities/product.dart';
import 'package:store_admin_panel/app/modules/manage_products/domain/value_objects/product_image_vo.dart';
import 'package:store_admin_panel/app/modules/manage_products/presenter/bloc/manage_products_bloc.dart';
import 'package:store_admin_panel/app/modules/manage_products/presenter/events/manage_products_events.dart';
import 'package:store_admin_panel/app/modules/manage_products/presenter/states/manage_products_state.dart';
import '../../../../../mocks/mocks.dart';

void main() {
  late ProductDTO dummyProduct;
  late GetProductsMock getProducts;
  late CreateProductMock createProduct;
  late UpdateProductMock updateProduct;
  late RemoveProductMock removeProduct;

  late ManageProductsBloc bloc;
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    dummyProduct = ProductDTO(
        productImageData:
            ProductImageVO(imagePath: 'test_resources/assets/0.jpg'),
        id: 'B');
  });

  setUp(() {
    getProducts = GetProductsMock();
    createProduct = CreateProductMock();
    updateProduct = UpdateProductMock();
    removeProduct = RemoveProductMock();
    bloc = ManageProductsBloc(
        getProducts: getProducts,
        createProduct: createProduct,
        updateProduct: updateProduct,
        removeProduct: removeProduct);
  });

  group('Fetch Products Bloc', () {
    blocTest<ManageProductsBloc, ManageProductsState>(
        'should emits [] when nothing is products available',
        build: () {
          when(() => getProducts("")).thenAnswer((_) async => const Right([]));
          return bloc;
        },
        act: (bloc) => bloc.add(FetchProductsEvent()),
        verify: (_) {
          verify(() => getProducts(any())).called(1);
        },
        expect: () => [
              isA<LoadingManageProductsState>(),
              isA<ResultManageProductsState>(),
            ]);
    blocTest<ManageProductsBloc, ManageProductsState>(
        'should emits exception when has error is product\'s fetch',
        build: () {
          when(() => getProducts("")).thenAnswer((_) async => Left(
              NoInternetConection(
                  message: "No have connection with internet")));
          return bloc;
        },
        act: (bloc) => bloc.add(FetchProductsEvent()),
        verify: (_) {
          verify(() => getProducts(any())).called(1);
        },
        expect: () => [
              isA<LoadingManageProductsState>(),
              isA<ExceptionManageProductsState>(),
            ]);
  });
  group('Create Product Bloc', () {
    blocTest<ManageProductsBloc, ManageProductsState>('should create product',
        build: () {
          when(() => createProduct.call(dummyProduct)).thenAnswer((_) async =>
              Right(Product(id: "B", productImage: ProductImageVO())));
          bloc.emit(ResultManageProductsState(
              [Product(id: "JAKJ", productImage: ProductImageVO())]));
          return bloc;
        },
        act: (bloc) => bloc.add(CreateProductEvent(dummyProduct)),
        expect: () => [
              isA<LoadingManageProductsState>(),
              isA<ResultManageProductsState>(),
            ]);
  });
  group('Remove Product Bloc', () {
    blocTest<ManageProductsBloc, ManageProductsState>('should remove product',
        build: () {
          when(() => removeProduct.call("JAKJ"))
              .thenAnswer((_) async => const Right(true));
          bloc.emit(ResultManageProductsState(
              [Product(id: "JAKJ", productImage: ProductImageVO())]));

          return bloc;
        },
        act: (bloc) => bloc.add(RemoveProductEvent(id: "JAKJ")),
        expect: () => [
              isA<LoadingManageProductsState>(),
              isA<ResultManageProductsState>(),
            ]);
  });
}
