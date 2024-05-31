import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthDataProvider{
  static Future<Object> login(event) async{
    
    String uri = 'http://localhost:3000/auth/login'; 
    final url = Uri.parse(uri);

    final body = {"email": event.useremail, "password": event.password};
    final jsonBody = jsonEncode(body);
    final headers = {"Content-Type": "application/json"};

    final res = await http.post(url, headers: headers, body: jsonBody);
    
    return res;
  }
}