import '../../../core/usecases/usecase.dart';
import '../../repositories/booking_repository.dart';

class CancelBookingUseCase implements UseCase<void, String> {
  final BookingRepository repository;

  CancelBookingUseCase(this.repository);

  @override
  Future<void> call(String params) async {
    return await repository.cancelBooking(params);
  }
}
