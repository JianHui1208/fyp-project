import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getItemCategoryGroupByItem() async {
  return await _sendAuthorizedGetRequest('/api/admin/getCategoryList');
}

Future<String> getItemByCategoryID(String categoryID) async {
  return await _sendAuthorizedGetRequest(
      '/api/admin/getItemByCateID/$categoryID');
}

Future<String> getItemByItemID(String itemID) async {
  return await _sendAuthorizedGetRequest('/api/admin/items/$itemID');
}

Future<String> addItem(dynamic value) async {
  return await _sendAuthorizedPostRequest('/api/admin/items', value);
}

Future<String> getStockInOutList() async {
  return await _sendAuthorizedGetRequest(
      '/api/admin/get-stockHistoryGroupByDate');
}

Future<String> getStockInOutDetail(String stockHistoryID) async {
  return await _sendAuthorizedGetRequest(
      '/api/admin/get-stockHistoryById/$stockHistoryID');
}

Future<String> getItemQuantity() async {
  return await _sendAuthorizedGetRequest('/api/admin/getItemQuantity');
}

Future<String> deleteItem(String itemID) async {
  return await _sendAuthorizedDeleteRequest('/api/admin/items/$itemID');
}

Future<String> _getToken() async {
  final prefs = await SharedPreferences.getInstance();
  final userInfo = prefs.getString('user_data') ?? '';
  final userObj = jsonDecode(userInfo);
  return userObj['response']['token'];
}

Future<String> _sendAuthorizedGetRequest(String url) async {
  final baseUrl = dotenv.env['BACKEND_URL'];
  final token = await _getToken();

  final response = await http.get(
    Uri.parse('$baseUrl$url'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<String> _sendAuthorizedDeleteRequest(String url) async {
  final baseUrl = dotenv.env['BACKEND_URL'];
  final token = await _getToken();

  final response = await http.delete(
    Uri.parse('$baseUrl$url'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<String> _sendAuthorizedPostRequest(String url, dynamic value) async {
  final baseUrl = dotenv.env['BACKEND_URL'];
  final token = await _getToken();

  final response = await http.post(
    Uri.parse('$baseUrl$url'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(value),
  );

  if (response.statusCode == 200) {
    dynamic responseObj = jsonDecode(response.body);
    return responseObj['status'].toString();
    // return responseObj['response']['status'].toString();
  } else if (response.statusCode == 422) {
    return '422';
  } else {
    return response.statusCode.toString();
  }
}
