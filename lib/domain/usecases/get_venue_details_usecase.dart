import '../../core/usecases/usecase.dart';
import '../entities/venue_entity.dart';
import '../repositories/venue_repository.dart';

class GetVenueDetailsUseCase implements UseCase<VenueEntity, String> {
  final VenueRepository repository;

  GetVenueDetailsUseCase(this.repository);

  @override
  Future<VenueEntity> call(String id) async {
    return await repository.getVenueDetails(id);
  }
}
