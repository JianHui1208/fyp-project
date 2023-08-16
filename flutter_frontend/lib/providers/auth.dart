import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> fetchUserData(String? phoneNumber, String? password) async {
  bool isLogging = false;
  var baseUrl = dotenv.env['BACKEND_URL'];

  try {
    final response = await http.post(
      Uri.parse('$baseUrl/api/users/user-login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'input': 'admin',
        'password': 'password',
      }),
    );

    if (response.statusCode == 200) {
      dynamic apiResponse = jsonDecode(response.body);
      if (apiResponse["status"] == 702) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_data', response.body);
        isLogging = true;
      } else {
        isLogging = false;
      }
    }

    return isLogging;
  } catch (e) {
    isLogging = false;
    return isLogging;
    // rethrow;
  }
}

Future<bool> registerUser(jsonData) async {
  bool isRegister = false;

  final response = await http.post(
    Uri.parse('http://202.171.50.208:4250/api/users/user-register'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonData,
  );

  try {
    if (response.statusCode == 200) {
      dynamic apiResponse = jsonDecode(response.body);
      if (apiResponse["status"] == 700) {
        isRegister = true;
      } else {
        isRegister = false;
      }
    }

    return isRegister;
  } catch (e) {
    rethrow;
  }
}
