import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../domain/usecases/create_product.dart';
import '../../domain/usecases/get_products.dart';
import '../../domain/usecases/remove_product.dart';
import '../events/manage_products_events.dart';
import '../states/manage_products_state.dart';

class ManageProductsBloc
    extends Bloc<ManageProductsEvent, ManageProductsState> {
  final GetProducts getProducts;
  final CreateProduct createProduct;
  final RemoveProduct removeProduct;

  ManageProductsBloc(
      {required this.getProducts,
      required this.createProduct,
      required this.removeProduct})
      : super(NoProductsAvailableManageProductsState()) {
    on<FetchProductsEvent>(_fetchProducts);
    on<CreateProductEvent>(_createProduct);
    on<RemoveProductEvent>(_removeProduct);
  }
  Future<void> _fetchProducts(FetchProductsEvent event, Emitter emit) async {
    emit(LoadingManageProductsState());
    final productsOrFailure = await getProducts(event.filterTerm);
    productsOrFailure.fold(
        (l) => emit(ExceptionManageProductsState(l.message!)),
        (r) => emit(ResultManageProductsState(r)));
  }

  Future<void> _createProduct(CreateProductEvent event, Emitter emit) async {
    ResultManageProductsState oldState = state as ResultManageProductsState;
    emit(LoadingManageProductsState());
    final result = await createProduct(event.product);
    result.fold((l) => emit(ExceptionManageProductsState(l.message!)), (r) {
      oldState.products.add(r);
      emit(ResultManageProductsState(oldState.products));
      Modular.to.pop();
    });
  }

  Future<void> _removeProduct(RemoveProductEvent event, Emitter emit) async {
    ResultManageProductsState oldState = state as ResultManageProductsState;
    emit(LoadingManageProductsState());

    final resultOrFailure = await removeProduct(event.id);
    resultOrFailure.fold((l) => emit(ExceptionManageProductsState(l.message!)),
        (r) {
      oldState.products.removeWhere((element) => element.id == event.id);
      emit(ResultManageProductsState(oldState.products));
    });
  }
}
