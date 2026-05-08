import '../../../core/usecases/usecase.dart';
import '../../entities/venue_entity.dart';
import '../../repositories/favorites_repository.dart';

class GetFavoritesUseCase implements UseCase<List<VenueEntity>, NoParams> {
  final FavoritesRepository repository;

  GetFavoritesUseCase(this.repository);

  @override
  Future<List<VenueEntity>> call(NoParams params) async {
    return await repository.getFavorites();
  }
}
