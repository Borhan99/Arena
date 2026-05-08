import '../../../core/usecases/usecase.dart';
import '../../entities/booking_entity.dart';
import '../../repositories/booking_repository.dart';

class SubmitBookingUseCase implements UseCase<void, BookingEntity> {
  final BookingRepository repository;

  SubmitBookingUseCase(this.repository);

  @override
  Future<void> call(BookingEntity params) async {
    return await repository.submitBooking(params);
  }
}
