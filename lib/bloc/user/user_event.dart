part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetUserByUsername extends UserEvent {
  final String username;
  const GetUserByUsername(
    this.username,
  );

  @override
  List<Object> get props => [username];
}


class GetUserRecent extends UserEvent {
  
}