abstract class UserEvent {}

class FetchUser extends UserEvent {
  final String id;
  FetchUser(this.id);
}
