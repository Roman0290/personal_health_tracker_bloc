import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:personal_health_tracker/local_storage/secure_storage.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<NavigateToSignUpPageEvent>(signUpEvent);
    on<AdminLogNavigateToSignUpPageEvent>(navigateToSignUpPageEvent);
    
    on<LogInEvent>(logInEvent);
    on<NavigateToLoginPageEvent>(navigateToLoginEvent);
    on<SignupUserEvent>(signupUserEvent);
    on<AdminLogEvent>(adminLogEvent);
  }

  FutureOr<void> signUpEvent(
      NavigateToSignUpPageEvent event, Emitter<AuthState> emit) {
    emit(LoginNavigateToSignupState());
  }
  FutureOr<void> navigateToSignUpPageEvent(
      AdminLogNavigateToSignUpPageEvent event, Emitter<AuthState> emit) {
    emit(AdminLogNavigateToSignupState());
  }

  FutureOr<void> logInEvent(LogInEvent event, Emitter<AuthState> emit) async {
    String uri = 'http://localhost:3000/auth/login';
    final url = Uri.parse(uri);

    final body = {"username": event.useremail, "password": event.password};
    final jsonBody = jsonEncode(body);
    final headers = {"Content-Type": "application/json"};

    final res = await http.post(url, headers: headers, body: jsonBody);
    Map response = jsonDecode(res.body);
    print(response);
    if (response.containsKey('message')) {
      var error = response["message"];

      if (error is! String) {
        error = error[0];
      }
      emit(LogInErrorState(error: error));
    } else {
      final secureStorage = SecureStorage().secureStorage;

      await secureStorage.write(key: "role", value: response["role"]);
      await secureStorage.write(key: "token", value: response["accessToken"]);
      await secureStorage.write(key: "username", value: response["username"]);
      await secureStorage.write(key: "email", value: response["email"]);

      emit(LogInSuccessState());
    }
  }

  FutureOr<void> navigateToLoginEvent(
      NavigateToLoginPageEvent event, Emitter<AuthState> emit) {
    emit(SignupNavigateToLoginState());
  }


  FutureOr<void> signupUserEvent(
      SignupUserEvent event, Emitter<AuthState> emit) async {
    String uri = 'http://localhost:3000/auth/signup';
    final url = Uri.parse(uri);
    final body = {
      "username": event.username,
      "email": event.email,
      "password": event.password
    };

    final jsonBody = jsonEncode(body);
    final headers = {"Content-Type": "application/json"};

    final res = await http.post(url, headers: headers, body: jsonBody);
    Map response = jsonDecode(res.body);
    print(response);
    if (res.statusCode != 201) {
      var error = response["message"];

      if (error is! String) {
        error = error[0];
      }
      emit(SignupError(error: error));
    } else {
      final secureStorage = SecureStorage().secureStorage;
      await secureStorage.write(key: "role", value: response["role"]);
      await secureStorage.write(key: "token", value: response["accessToken"]);
      await secureStorage.write(key: "username", value: response["username"]);
      await secureStorage.write(key: "email", value: response["email"]);

      emit(SignUpSuccessState());
    }
  }

  

  

  FutureOr<void> adminLogEvent(AdminLogEvent event, Emitter<AuthState> emit) async {
    String uri = 'http://localhost:3000/auth/login';
    final url = Uri.parse(uri);

    final body = {"username": event.useremail, "password": event.password};
    final jsonBody = jsonEncode(body);
    final headers = {"Content-Type": "application/json"};

    final res = await http.post(url, headers: headers, body: jsonBody);
    Map response = jsonDecode(res.body);
    print(response);
    if (response.containsKey('message')) {
      var error = response["message"];

      if (error is! String) {
        error = error[0];
      }
      emit(AdminLogErrorState(error: error));
    } else {
      final secureStorage = SecureStorage().secureStorage;

      await secureStorage.write(key: "role", value: response["role"]);
      await secureStorage.write(key: "token", value: response["accessToken"]);
      await secureStorage.write(key: "username", value: response["username"]);
      await secureStorage.write(key: "email", value: response["email"]);

      emit(AdminLogSuccessState());
    }
  }
}