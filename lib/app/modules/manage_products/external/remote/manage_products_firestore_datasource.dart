import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../domain/entities/product.dart';
import '../../infra/interfaces/manage_products_datasource.dart';
import '../../infra/mappers/product_mapper.dart';

class ManageProductsFirestoreDataSource implements IManageProductsDataSource {
  FirebaseFirestore firestore;
  FirebaseStorage firebaseStorage;
  ManageProductsFirestoreDataSource(
      {required this.firestore, required this.firebaseStorage});

  @override
  Future<List<Map<String, dynamic>>> getProducts({String filter = ""}) async {
    final list = await firestore
        .collection('products')
        .where('title', isGreaterThanOrEqualTo: filter)
        .where('title', isLessThan: '${filter}z')
        .get();
    List<Map<String, dynamic>> valueConverted =
        await Future.wait(list.docs.map((element) async {
      final imageUrl = await firebaseStorage
          .ref()
          .child(element['filename'])
          .getDownloadURL();
      final Map<String, dynamic> product = element.data();
      product['filename'] = imageUrl;
      return product..addAll({'id': element.id});
    }).toList());

    return valueConverted;
  }

  @override
  Future<Product> createProduct(Product product) async {
    final newProduct = await firestore
        .collection('products')
        .add(ProductMapper.toMap(product));
    product.id = newProduct.id;
    return product;
  }

  @override
  Future<void> removeProduct(String id) async {
    try {
      await firestore.collection('products').doc(id).delete();
    } on FirebaseException catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<void> updateProduct() {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }

  @override
  Future<String> uploadImage(File image) async {
    try {
      TaskSnapshot uploadTask =
          await firebaseStorage.ref(image.path).putFile(image);
      final url = await uploadTask.ref.getDownloadURL();
      return url;
    } on FirebaseException catch (error) {
      throw error;
    }
  }
}
