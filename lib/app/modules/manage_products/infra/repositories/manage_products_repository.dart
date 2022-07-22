import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../../../core/erros/client_http_failures.dart';
import '../../../../core/erros/general_failures.dart';
import '../../domain/dtos/product_dto.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/interfaces/manage_products_repository.dart';
import '../interfaces/manage_products_datasource.dart';
import '../mappers/product_mapper.dart';

class ManageProductsRepository implements IManageProductsRepository {
  final IManageProductsDataSource _dataSource;

  ManageProductsRepository(this._dataSource);

  @override
  Future<Either<Failure, Product>> createProduct(
      {required ProductDTO product}) async {
    try {
      final response =
          await _dataSource.createProduct(product.convertToProduct());
      return Right(response);
    } on NoInternetConection catch (error) {
      return Left(
          NoInternetConection(message: "Não há conexão com a internet"));
    } catch (error) {
      return Left(
          GeneralFailure(message: "Ocorreu um erro ao pegar os produtos."));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProducts(
      {String filter = "", int page = 0}) async {
    try {
      final response = await _dataSource.getProducts(filter: filter);
      final convertResponse =
          response.map((value) => ProductMapper.fromMap(value)).toList();
      return Right(convertResponse);
    } on NoInternetConection catch (error) {
      return Left(
          NoInternetConection(message: "Não há conexão com a internet"));
    } catch (error) {
      return Left(
          GeneralFailure(message: "Ocorreu um erro ao pegar os produtos."));
    }
  }

  @override
  Future<Either<Failure, bool>> updateProduct() {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> removeProduct(String id) async {
    try {
      await _dataSource.removeProduct(id);
      return const Right(true);
    } on NoInternetConection catch (error) {
      return Left(
          NoInternetConection(message: "Não há conexão com a internet"));
    } catch (error) {
      return Left(
          GeneralFailure(message: "Ocorreu um erro ao pegar os produtos."));
    }
  }

  @override
  Future<Either<Failure, String>> uploadImageProduct(File image) async {
    try {
      final response = await _dataSource.uploadImage(image);
      return Right(response);
    } catch (error) {
      return Left(GeneralFailure(message: error.toString()));
    }
  }
}
