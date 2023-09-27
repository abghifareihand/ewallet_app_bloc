part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthCheckEmail extends AuthEvent {
  final String email;
  const AuthCheckEmail(this.email);

  @override
  List<Object> get props => [email];
}


class AuthRegister extends AuthEvent {
  final RegisterModel data;
  const AuthRegister(this.data);

  @override
  List<Object> get props => [data];
}
class AuthLogin extends AuthEvent {
  final LoginModel data;
  const AuthLogin(this.data);

  @override
  List<Object> get props => [data];
}

class AuthGetCurrentUser extends AuthEvent {
  
}