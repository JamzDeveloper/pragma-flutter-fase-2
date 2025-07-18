abstract class AuthEvent {}

class AuthLoginRequested extends AuthEvent {
  final String username;
  final String password;

  AuthLoginRequested({required this.username, required this.password});
}
