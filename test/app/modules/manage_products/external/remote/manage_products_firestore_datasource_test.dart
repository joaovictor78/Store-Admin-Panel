import 'dart:io';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:store_admin_panel/app/modules/manage_products/domain/entities/product.dart';
import 'package:store_admin_panel/app/modules/manage_products/external/remote/manage_products_firestore_datasource.dart';

void main() {
  late FakeFirebaseFirestore firestore;
  late MockFirebaseStorage firebaseStorage;
  late ManageProductsFirestoreDataSource datasource;
  _addFakeProductsFactory() async {
    await firestore.collection('products').add({
      "title": "Brown eggs",
      "type": "dairy",
      "description": "Raw organic brown eggs in a basket",
      "filename": "0.jpg",
      "height": 600,
      "width": 400,
      "price": 28.1,
      "rating": 4
    });
    await firestore.collection('products').add({
      "title": "Asparagus",
      "type": "vegetable",
      "description": "Asparagus with ham on the wooden table",
      "filename": "24.jpg",
      "height": 450,
      "width": 299,
      "price": 18.95,
      "rating": 3
    });
  }

  _addFileFilesFactory() async {
    await firebaseStorage.ref().putFile(File('test_resources/assets/0.jpg'));
    await firebaseStorage.ref().putFile(File('test_resources/assets/24.jpg'));
  }

  setUp(() async {
    firestore = FakeFirebaseFirestore();
    firebaseStorage = MockFirebaseStorage();
    datasource = ManageProductsFirestoreDataSource(
        firestore: firestore, firebaseStorage: firebaseStorage);
    await _addFakeProductsFactory();
    await _addFileFilesFactory();
  });

  group("Get Products DataSource |", () {
    test("should return all products if filter parameter is empty", () async {
      final datasource = ManageProductsFirestoreDataSource(
          firestore: firestore, firebaseStorage: firebaseStorage);
      final response = await datasource.getProducts(filter: "");
      expect(response, isA<List<Map<String, dynamic>>>());
      expect(response[0]['id'], isNotNull);
      expect(response[0]['title'], 'Brown eggs');
      expect(response[0]['filename'], contains('https://'));
    });
    test("should only return specific products from the filter parameter",
        () async {
      final response = await datasource.getProducts(filter: "Asparagus");
      expect(response, isA<List<Map<String, dynamic>>>());
      expect(response[0]['title'], contains('Asparagus'));
    });
  });
  group("Create Product DataSource |", () {
    test("should  return imge url if upload product image", () async {
      final firebaseStorage = MockFirebaseStorage();
      final datasource = ManageProductsFirestoreDataSource(
          firestore: firestore, firebaseStorage: firebaseStorage);
      final credentials = await firebaseStorage
          .ref()
          .putFile(File('test_resources/assets/0.jpg'));
      final url =
          await datasource.uploadImage(File('test_resources/assets/0.jpg'));
      expect(url, contains('https://'));
    });
    test('should return product if create with sucess', () async {
      final firestore = FakeFirebaseFirestore();
      final datasource = ManageProductsFirestoreDataSource(
          firestore: firestore, firebaseStorage: firebaseStorage);
      await firestore.collection('products').add({
        "title": "Asparagus",
        "type": "vegetable",
        "description": "Asparagus with ham on the wooden table",
        "filename": "24.jpg",
        "height": 450,
        "width": 299,
        "price": 18.95,
        "rating": 3
      });
      final response = await datasource.createProduct(Product());
      expect(response, isA<Product>());
    });
  });
  group("Remove Product DataSource |", () {
    test("should remove the product", () async {
      final allProducts = await firestore.collection('products').get();
      final firstProduct = allProducts.docs.first;
      await datasource.removeProduct(firstProduct.id);
      final currentAllProducts = await firestore.collection('products').get();
      expect(currentAllProducts.docs.first.id, isNot(firstProduct.id));
    });
  });
}
