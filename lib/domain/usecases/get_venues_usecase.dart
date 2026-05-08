import '../../core/usecases/usecase.dart';
import '../entities/venue_entity.dart';
import '../repositories/venue_repository.dart';

class GetVenuesUseCase implements UseCase<List<VenueEntity>, NoParams> {
  final VenueRepository repository;

  GetVenuesUseCase(this.repository);

  @override
  Future<List<VenueEntity>> call(NoParams params) async {
    return await repository.getVenues();
  }
}
