import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'domain/usecases/create_product.dart';
import 'domain/usecases/get_products.dart';
import 'domain/usecases/remove_product.dart';
import 'domain/usecases/update_product.dart';
import 'external/remote/manage_products_firestore_datasource.dart';
import 'infra/repositories/manage_products_repository.dart';
import 'presenter/bloc/manage_products_bloc.dart';
import 'presenter/pages/create_product_page.dart';
import 'presenter/pages/list_products_page.dart';
import 'presenter/pages/update_product_page.dart';

class ManageProductsModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => ManageProductsFirestoreDataSource(
            firestore: FirebaseFirestore.instance,
            firebaseStorage: FirebaseStorage.instance)),
        Bind.lazySingleton((i) => ManageProductsRepository(i())),
        Bind.lazySingleton((i) => GetProducts(i())),
        Bind.lazySingleton((i) => CreateProduct(i())),
        Bind.lazySingleton((i) => UpdateProduct(i())),
        Bind.lazySingleton((i) => RemoveProduct(i())),
        Bind.lazySingleton((i) => ManageProductsBloc(
            getProducts: i<GetProducts>(),
            createProduct: i<CreateProduct>(),
            updateProduct: i<UpdateProduct>(),
            removeProduct: i<RemoveProduct>()))
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/list-products',
            child: (context, args) => const ListProductsPage()),
        ChildRoute('/create-product',
            child: (context, args) => const CreateProductPage()),
        ChildRoute('/update-product',
            child: (context, args) => UpdateProductPage(args.data))
      ];
}
