import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl(this.localDataSource);

  @override
  Future<bool> login(String username, String password) async {
    // DEMO login — no backend logic
    if (username == 'demo' && password == 'demo123') {
      await localDataSource.saveUserSession('demo_user_001');
      return true;
    }
    return false;
  }

  @override
  Future<void> logout() async {
    await localDataSource.clearSession();
  }

  @override
  Future<bool> isLoggedIn() async {
    return await localDataSource.isLoggedIn();
  }

  @override
  Future<String?> getUserId() async {
    return await localDataSource.getUserId();
  }
}
