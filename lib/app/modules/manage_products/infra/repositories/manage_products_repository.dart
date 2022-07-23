import 'package:dartz/dartz.dart';
import '../../../../core/erros/client_http_failures.dart';
import '../../../../core/erros/general_failures.dart';
import '../../domain/dtos/product_dto.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/interfaces/manage_products_repository.dart';
import '../../domain/value_objects/product_image_vo.dart';
import '../interfaces/manage_products_datasource.dart';

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
          response.map((value) => ProductDTO.fromMap(value)).toList();
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
  Future<Either<Failure, Product>> updateProduct(String id,
      {required Product product}) async {
    try {
      final response = await _dataSource.updateProduct(id, product);
      response['id'] = id;
      final updatedProduct = ProductDTO.fromMap(response);
      return Right(updatedProduct);
    } catch (error) {
      return Left(GeneralFailure(message: error.toString()));
    }
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
  Future<Either<Failure, ProductImageVO>> uploadImageProduct(
      String imagePath) async {
    try {
      final response = await _dataSource.uploadImage(imagePath);
      return Right(ProductImageVO(
          name: response['filename'], imagePath: response['image_path']));
    } catch (error) {
      return Left(GeneralFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductImageVO>> updateImageProduct(
      String id, String imagePath) async {
    try {
      final response = await _dataSource.updateImage(id, imagePath);
      return Right(ProductImageVO(
          name: response['filename'], imagePath: response['image_path']));
    } catch (error) {
      return Left(GeneralFailure(message: error.toString()));
    }
  }
}
