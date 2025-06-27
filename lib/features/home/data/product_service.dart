import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:fake_store/features/home/models/product.dart';
import 'package:http/http.dart' as http;

class Failure {
  final String message;
  Failure(this.message);
}

class ProductService {
  Future<Either<Failure, List<ProductModel>>> fetchProducts() async {
    try {
      final url = Uri.parse("https://fakestoreapi.com/products");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List list = jsonDecode(response.body);
        final products = list.map((e) => ProductModel.fromJson(e)).toList();

        return Right(products);
      } else {
        return Left(Failure('Error ${response.statusCode}: ${response.body}'));
      }
    } catch (err) {
      return Left(Failure('Excepcion $err'));
    }
  }
}
