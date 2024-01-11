import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:travel_management_mobile/core/api.url.dart';
import 'package:travel_management_mobile/service/storage.service.dart';

class AuthentificationService {
  final headers = {'Content-Type': 'application/json'};

  Future<http.Response> login(String email, String password) async {
    try {
      final data = {
        'email': email,
        'password': password,
      };

      final response = await http.post(
        Uri.parse('${ApiUrl.springUrl}/api/auth/authenticate'),
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print(responseData['access_token']);
        print(responseData['refresh_token']);
        await StorageService().setToken(responseData['access_token']);
        await StorageService().setRefreshToken(responseData['refresh_token']);
        print('object response ===> $response');
        return response;
      } else {
        print('login service failed with status code $response');
        return response;
      }
    } catch (e) {
      print('login service response $e');
      throw Exception('Failed to log in');
    }
  }

  Future<http.Response> register(String firstName, String lastName,
      String email, String password, String tel) async {
    try {
      final data = {
        'email': email,
        'firstName': firstName,
        'password': password,
        'lastName': lastName,
        'role': "Demandeur",
        'tel': tel,
      };

      final response = await http.post(
          Uri.parse('${ApiUrl.springUrl}/api/auth/register'),
          headers: headers,
          body: jsonEncode(data));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print(responseData['access_token']);
        print(responseData['refresh_token']);
        await StorageService().setToken(responseData['access_token']);
        await StorageService().setRefreshToken(responseData['refresh_token']);
        return response;
      } else {
        print('registration service failed with status code $response');
      }
      return response;
    } catch (e) {
      print('registration service response $e');
      throw Exception('Failed to register');
    }
  }
}
