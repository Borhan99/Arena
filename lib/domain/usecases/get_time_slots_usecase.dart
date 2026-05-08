import '../../core/usecases/usecase.dart';
import '../entities/booking_entity.dart';
import '../repositories/venue_repository.dart';

class GetTimeSlotsParams {
  final String venueId;
  final DateTime date;
  GetTimeSlotsParams({required this.venueId, required this.date});
}

class GetTimeSlotsUseCase implements UseCase<List<TimeSlotEntity>, GetTimeSlotsParams> {
  final VenueRepository repository;
  GetTimeSlotsUseCase(this.repository);

  @override
  Future<List<TimeSlotEntity>> call(GetTimeSlotsParams params) async {
    return await repository.getTimeSlots(params.venueId, params.date);
  }
}
