import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:travel_management_mobile/core/api.url.dart';
import 'package:travel_management_mobile/model/user.model.dart';
import 'package:travel_management_mobile/service/storage.service.dart';

class UserService {
  Future<Map<String, dynamic>?> decodeToken() async {
    final token = await StorageService().getToken();
    if (token != null) {
      try {
        final parts = token.split('.');
        if (parts.length == 3) {
          final payload = base64.decode(base64.normalize(parts[1]));
          final payloadString = utf8.decode(payload);
          return json.decode(payloadString);
        }
      } catch (e) {
        print('Error decoding token: $e');
      }
    }

    return null;
  }

  Future<int> getUserId() async {
    final Map<String, dynamic>? decodedToken = await decodeToken();
    return decodedToken?['id'];
  }

  Future<String> getUserRole() async {
    final Map<String, dynamic>? decodedToken = await decodeToken();
    return decodedToken?['role'];
  }

  Future<UserModel> getUserInfo() async {
    try {
      final Map<String, dynamic>? decodedToken = await decodeToken();
      if (decodedToken != null && decodedToken.containsKey('id')) {
        final userId = decodedToken['id'];
        final token = await StorageService().getToken();
        final headers = {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        };
        final response = await http.get(
          Uri.parse('${ApiUrl.springUrl}/users/$userId'),
          headers: headers,
        );
        if (response.statusCode == 200) {
          final Map<String, dynamic> userData = json.decode(response.body);
          return UserModel.fromJson(userData);
        } else {
          throw Exception('Failed to load user information');
        }
      } else {
        throw Exception('User ID not found in the decoded token');
      }
    } catch (e) {
      throw Exception('Error fetching user information: $e');
    }
  }

  Future<List<UserModel>> getAllUsers() async {
    try {
      final token = await StorageService().getToken();
      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final response = await http.get(
        Uri.parse('${ApiUrl.springUrl}/users/'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<UserModel> users = data.map((e) => UserModel.fromJson(e)).toList();
        return users;
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      print('Error fetching users: $e');
      throw Exception('Error fetching users: $e');
    }
  }

  Future<UserModel> getUserById(int id) async {
    try {
      final token = await StorageService().getToken();
      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final response = await http.get(
        Uri.parse('${ApiUrl.springUrl}/users/$id'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> userData = json.decode(response.body);
        return UserModel.fromJson(userData);
      } else {
        throw Exception('Failed to load user');
      }
    } catch (e) {
      print('Error fetching user: $e');
      throw Exception('Error fetching user: $e');
    }
  }

  Future<UserModel> saveUser(UserModel user) async {
    try {
      final token = await StorageService().getToken();
      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final response = await http.post(
        Uri.parse('${ApiUrl.springUrl}/users/save'),
        headers: headers,
        body: json.encode(user.toJson()),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> userData = json.decode(response.body);
        return UserModel.fromJson(userData);
      } else {
        throw Exception('Failed to save user');
      }
    } catch (e) {
      print('Error saving user: $e');
      throw Exception('Error saving user: $e');
    }
  }

  Future<void> deleteUser(int id) async {
    try {
      final token = await StorageService().getToken();
      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final response = await http.delete(
        Uri.parse('${ApiUrl.springUrl}/users/$id'),
        headers: headers,
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete user');
      }
    } catch (e) {
      print('Error deleting user: $e');
      throw Exception('Error deleting user: $e');
    }
  }

  Future<UserModel?> updateProfile(String updatedFname, String updatedLname,String updatedPhone) async {
    try {
      final token = await StorageService().getToken();
      final Map<String, dynamic>? decodedToken = await decodeToken();
      final userId = decodedToken?['id'];
      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };
      final data = {
        'firstName': updatedFname,
        'lastName': updatedLname,
        'tel': updatedPhone,
      };

      final response = await http.put(
        Uri.parse('${ApiUrl.springUrl}/users/update/$userId'),
        headers: headers,
        body: json.encode(data),
      );
      print('Update Profile Response: ${response.body}');
      print('Update Profile Status Code: ${response.statusCode}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (response.body.isNotEmpty) {
          final Map<String, dynamic> updatedUserData = json.decode(response.body);
          return UserModel.fromJson(updatedUserData);
        } else {
          return null;
        }
      } else {
        throw Exception('Failed to update profile: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Update Profile Error: $e');
      throw Exception('Error updating profile: $e');
    }
  }


  Future<UserModel> findUserByUsername(String username) async {
    try {
      final token = await StorageService().getToken();
      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final response = await http.get(
        Uri.parse('${ApiUrl.springUrl}/users/username/$username'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> userData = json.decode(response.body);
        return UserModel.fromJson(userData);
      } else {
        throw Exception('Failed to find user by username');
      }
    } catch (e) {
      print('Error finding user by username: $e');
      throw Exception('Error finding user by username: $e');
    }
  }

  Future<UserModel?> findUserByEmail(String email) async {
    try {
      final token = await StorageService().getToken();
      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final response = await http.get(
        Uri.parse('${ApiUrl.springUrl}/users/email/$email'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> userData = json.decode(response.body);
        return UserModel.fromJson(userData);
      } else {
        return null;
      }
    } catch (e) {
      print('Error finding user by email: $e');
      throw Exception('Error finding user by email: $e');
    }
  }

  Future<List<UserModel>> findByRole(String role) async {
    try {
      final token = await StorageService().getToken();
      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final response = await http.get(
        Uri.parse('${ApiUrl.springUrl}/users/role/$role'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<UserModel> users = data.map((e) => UserModel.fromJson(e)).toList();
        return users;
      } else {
        throw Exception('Failed to find users by role');
      }
    } catch (e) {
      print('Error finding users by role: $e');
      throw Exception('Error finding users by role: $e');
    }
  }
}
