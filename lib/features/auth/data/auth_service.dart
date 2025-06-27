import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';

class Failure {
  final String message;
  Failure(this.message);
}

class AuthService {
  final String baseUrl = 'https://fakestoreapi.com';

  Future<Either<Failure, LoginResponse>> login(LoginRequest request) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 401) {
        return Left(Failure('Credenciales invalidas'));
      }
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Right(LoginResponse.fromJson(data));
      } else {
        return Left(Failure('Error ${response.statusCode}: ${response.body}'));
      }
    } catch (e) {

      return Left(Failure('Excepción: $e'));
    }
  }
}
