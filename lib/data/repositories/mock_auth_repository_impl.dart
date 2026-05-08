import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';

class MockAuthRepositoryImpl implements AuthRepository {
  bool _isAuthenticated = false;

  @override
  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    _isAuthenticated = true;
    return true;
  }

  @override
  Future<bool> register(String name, String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    _isAuthenticated = true;
    return true;
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _isAuthenticated = false;
  }

  @override
  Future<bool> checkAuthStatus() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _isAuthenticated;
  }
  @override
  Future<UserEntity?> getCurrentUser() async {
    if (!_isAuthenticated) return null;
    return const UserEntity(
      id: 'mock-user-id',
      email: 'mock@arena.com',
      name: 'Mock User',
    );
  }
}
