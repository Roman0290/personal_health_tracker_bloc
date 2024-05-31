import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart%20';
import 'package:personal_health_tracker/presention/screens/auth/data%20provider/auth_data_provider.dart';
import '../../../../local_storage/secure_storage.dart';
class AuthRepository{
  static Future<String> login(event) async{
    final res = await AuthDataProvider.login(event) as Response;
    print(res.body);
    final response = jsonDecode(res.body);
    print(response);
    if (res.statusCode>=200 && res.statusCode<300) {
      final secureStorage = SecureStorage().secureStorage;

      await secureStorage.write(key: "token", value: response["token"]);

      return "success";
  }
  return response["message"];
  }
}