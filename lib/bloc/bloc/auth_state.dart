part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}


final class AuthFailed extends AuthState {
  final String error;
  const AuthFailed(this.error);

  @override
  List<Object> get props => [error];
}

final class AuthCheckEmailSuccess extends AuthState {}

final class AuthSuccess extends AuthState {
  final UserModel user;
  const AuthSuccess(this.user);

  @override
  List<Object> get props => [user];
}