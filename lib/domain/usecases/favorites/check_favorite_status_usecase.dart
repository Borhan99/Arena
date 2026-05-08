import '../../../core/usecases/usecase.dart';
import '../../repositories/favorites_repository.dart';

class CheckFavoriteStatusUseCase implements UseCase<bool, String> {
  final FavoritesRepository repository;

  CheckFavoriteStatusUseCase(this.repository);

  @override
  Future<bool> call(String params) async {
    return await repository.isFavorite(params);
  }
}
