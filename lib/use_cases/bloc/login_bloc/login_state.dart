part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoadingLoginState extends LoginState {}

final class SuccessLoginState extends LoginState {}

final class FailedLoginState extends LoginState {
  final String message;
  const FailedLoginState({required this.message});
}
