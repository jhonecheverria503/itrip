part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

final class DoLoginEvent extends LoginEvent {
  final String email;
  final String password;

  const DoLoginEvent({required this.email, required this.password});
}
