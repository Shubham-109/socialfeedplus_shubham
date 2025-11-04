import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class AuthLocalDataSource {
  Future<void> saveUserSession(String userId);
  Future<String?> getUserId();
  Future<bool> isLoggedIn();
  Future<void> clearSession();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage storage;

  AuthLocalDataSourceImpl({required this.storage});

  static const _keyUserId = 'USER_ID';
  static const _keyIsLoggedIn = 'IS_LOGGED_IN';

  @override
  Future<void> saveUserSession(String userId) async {
    await storage.write(key: _keyUserId, value: userId);
    await storage.write(key: _keyIsLoggedIn, value: 'true');
  }

  @override
  Future<String?> getUserId() async {
    return await storage.read(key: _keyUserId);
  }

  @override
  Future<bool> isLoggedIn() async {
    final value = await storage.read(key: _keyIsLoggedIn);
    return value == 'true';
  }

  @override
  Future<void> clearSession() async {
    await storage.deleteAll();
  }
}
