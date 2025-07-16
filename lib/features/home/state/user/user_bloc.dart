import 'package:fake_store/features/home/state/user/user_event.dart';
import 'package:fake_store/features/home/state/user/user_state.dart';
import 'package:fake_store_client/fake_store_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final FakeStoreClient userService;
  UserBloc(this.userService) : super(UserInitial()) {
    on<FetchUser>((event, emit) async {
      emit(UserLoading());

      final result = await userService.getUser(event.id);

      result.fold(
        (failure) => emit(UserError(failure)),
        (user) => emit(UserLoaded(user)),
      );
    });
  }
}
