abstract class UserEvent {}

class FetchUser extends UserEvent {
  final int id;
  FetchUser(this.id);
}
