import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:fake_store/features/home/models/user.dart';
import 'package:http/http.dart' as http;

class Failure {
  final String message;
  Failure(this.message);
}

class UserService {
  Future<Either<Failure, UserModel>> fetchUser(String userId) async {
    final url = Uri.parse("https://fakestoreapi.com/users/$userId");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final user = UserModel.fromJson(json);

        return Right(user);
      } else {
        return Left(
          Failure("Error al obtener el usuario: ${response.statusCode}"),
        );
      }
    } catch (err) {
      return Left(Failure('Exception al obtener el usuario: $err'));
    }
  }
}
