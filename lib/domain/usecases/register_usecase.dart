import '../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class RegisterParams {
  final String name;
  final String email;
  final String password;
  RegisterParams({
    required this.name,
    required this.email,
    required this.password,
  });
}

class RegisterUseCase implements UseCase<bool, RegisterParams> {
  final AuthRepository repository;
  RegisterUseCase(this.repository);

  @override
  Future<bool> call(RegisterParams params) async {
    return await repository.register(params.name, params.email, params.password);
  }
}
