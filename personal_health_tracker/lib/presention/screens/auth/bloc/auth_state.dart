part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

abstract class AuthActionState extends AuthState {}

final class AuthInitial extends AuthState {}

class LoginNavigateToSignupState extends AuthActionState {}

class AdminLogNavigateToSignupState extends AuthActionState {}

class SignupNavigateToLoginState extends AuthActionState {}

// loding states
class LoginLoadingState extends AuthActionState{}

class AdminLogLoadingState extends AuthActionState {}

class SignupLoadingState extends AuthActionState{}


//Success tates

class LogInSuccessState extends AuthActionState {}

class AdminLogSuccessState extends AuthActionState {}

class SignUpSuccessState extends AuthActionState {}
//error states

class SignupError extends AuthActionState {
  final String error;
  SignupError({required this.error});
}

class LogInErrorState extends AuthActionState {
  final String error;
  LogInErrorState({required this.error});
}

class AdminLogErrorState extends AuthActionState {
  final String error;
  AdminLogErrorState({required this.error});
}
