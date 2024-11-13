import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginProvider with ChangeNotifier {
  String? _token;
  bool _isLoading = false;

  String? get token => _token;
  bool get isLoading => _isLoading;

  Future<void> login(String username, String password) async {
    final url = Uri.parse('https://flutter-amr.noviindus.in/api/Login');
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        url,
        body: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        _token = responseData['token'];
        notifyListeners();
      } else {
        throw Exception('Failed to login');
      }
    } catch (error) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void logout() {
    _token = null;
    notifyListeners();
  }
}
