
part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

abstract class AuthActionState extends AuthState {}

final class AuthInitial extends AuthState {}

class LoginNavigateToSignupState extends AuthActionState {}

class AdminLogNavigateToSignupState extends AuthActionState {}

class SignupNavigateToLoginState extends AuthActionState {}

class LogInSuccessState extends AuthActionState {}

class AdminLogSuccessState extends AuthActionState {}


class LogInErrorState extends AuthActionState {
  final String error;
  LogInErrorState({required this.error});
}

class AdminLogErrorState extends AuthActionState {
  final String error;
  AdminLogErrorState({required this.error});
}


class SignUpSuccessState extends AuthActionState {}

class SignupError extends AuthActionState {
  final String error;
  SignupError({required this.error});
}


