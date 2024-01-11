import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  final storage = const FlutterSecureStorage();

  Future<void> setToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }

  Future<void> setRefreshToken(String token) async {
    await storage.write(key: 'refresh_token', value: token);
  }

  Future<void> clearTokens() async {
    try {
      await storage.delete(key: 'token');
      await storage.delete(key: 'refresh_token');
    } catch (e) {
      print('Error clearTokens $e');
    }
  }

  Future<String?> getRefreshToken() async {
    return await storage.read(key: 'refresh_token');
  }

  Future<void> setUid(String uid) async {
    await storage.write(key: 'uid', value: uid);
  }

  Future<String?> getUid() async {
    return await storage.read(key: 'uid');
  }

  Future<void> deleteAll() async {
    await storage.deleteAll();
  }
}
