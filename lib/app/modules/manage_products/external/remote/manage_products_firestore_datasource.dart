import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../domain/dtos/product_dto.dart';
import '../../domain/entities/product.dart';
import '../../infra/interfaces/manage_products_datasource.dart';

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
      product['filename'] = element.data()['filename'];
      product['image_path'] = imageUrl;
      return product..addAll({'id': element.id});
    }).toList());

    return valueConverted;
  }

  @override
  Future<Product> createProduct(Product product) async {
    final newProduct =
        await firestore.collection('products').add(ProductDTO.toMap(product));
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
  Future<Map<String, dynamic>> updateProduct(String id, Product product) async {
    try {
      final productMap = ProductDTO.toMap(product);
      await firestore
          .collection('products')
          .doc(id)
          .update(ProductDTO.toMap(product));
      return productMap;
    } on FirebaseException catch (error) {
      throw error;
    }
  }

  @override
  Future<Map<String, dynamic>> uploadImage(String imagePath) async {
    try {
      File image = File(imagePath);
      String path = image.path.split('/').last;
      TaskSnapshot uploadTask = await firebaseStorage.ref(path).putFile(image);
      final url = await uploadTask.ref.getDownloadURL();
      Map<String, dynamic> data = {
        'filename': uploadTask.ref.name,
        'image_path': url
      };
      return data;
    } on FirebaseException catch (error) {
      throw error;
    }
  }

  @override
  Future<Map<String, dynamic>> updateImage(String id, String imagePath) async {
    try {
      File image = File(imagePath);
      TaskSnapshot uploadTask = await firebaseStorage.ref(id).putFile(image);
      final url = await uploadTask.ref.getDownloadURL();
      Map<String, dynamic> data = {
        'filename': uploadTask.ref.name,
        'image_path': url
      };
      return data;
    } on FirebaseException catch (error) {
      throw error;
    }
  }
}
