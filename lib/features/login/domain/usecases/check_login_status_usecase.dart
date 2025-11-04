import '../repositories/auth_repository.dart';

class CheckLoginStatusUseCase {
  final AuthRepository repository;
  CheckLoginStatusUseCase(this.repository);

  Future<bool> call() => repository.isLoggedIn();
}
