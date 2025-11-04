part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object?> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  final String username;
  final String password;

  const LoginButtonPressed(this.username, this.password);

  @override
  List<Object?> get props => [username, password];
}

class CheckLoginStatus extends LoginEvent {}

class LogoutButtonPressed extends LoginEvent {}
