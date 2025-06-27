import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../../auth/data/auth_service.dart';
import '../../auth/models/login_request.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;

  AuthBloc(this.authService) : super(AuthInitial()) {
    on<AuthLoginRequested>((event, emit) async {
      emit(AuthLoading());

      final result = await authService.login(
        LoginRequest(username: event.username, password: event.password),
      );

      result.fold(
        (failure) => emit(AuthFailure(failure.message)),
        // (response) => emit(AuthSuccess(response.token)),
        (response) {
          final decodedToken = JwtDecoder.decode(response.token);
          final userId = decodedToken["sub"].toString();

          emit(AuthSuccess(response.token, userId));
        },
      );
    });
  }
}
