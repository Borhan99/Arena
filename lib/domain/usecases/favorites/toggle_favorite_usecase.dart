import '../../../core/usecases/usecase.dart';
import '../../entities/venue_entity.dart';
import '../../repositories/favorites_repository.dart';

class ToggleFavoriteUseCase implements UseCase<void, VenueEntity> {
  final FavoritesRepository repository;

  ToggleFavoriteUseCase(this.repository);

  @override
  Future<void> call(VenueEntity params) async {
    return await repository.toggleFavorite(params);
  }
}
