import 'package:fake_store/features/home/data/user_service.dart';
import 'package:fake_store/features/home/state/user_event.dart';
import 'package:fake_store/features/home/state/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService userService;
  UserBloc(this.userService) : super(UserInitial()) {
    on<FetchUser>((event, emit) async {
      emit(UserLoading());

      final result = await userService.fetchUser(event.id);

      result.fold(
        (failure) => emit(UserError(failure.message)),
        (user) => emit(UserLoaded(user)),
      );
    });
  }
}
