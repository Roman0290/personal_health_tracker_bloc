part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class LogInEvent extends AuthEvent {
  final String useremail;
  final String password;

  LogInEvent({required this.useremail, required this.password});
}

class NavigateToSignUpPageEvent extends AuthEvent {}

class AdminLogNavigateToSignUpPageEvent extends AuthEvent {}


class NavigateToLoginPageEvent extends AuthEvent {}


class SignupUserEvent extends AuthEvent {
  final String username;
  final String password;
  final String email;
  

  SignupUserEvent(
      {required this.username,
      required this.password,
      required this.email,
      });
}

class AdminLogEvent extends AuthEvent {
  final String useremail;
  final String password;

  AdminLogEvent({required this.useremail, required this.password});

}