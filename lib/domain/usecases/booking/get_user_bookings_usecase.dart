import '../../../core/usecases/usecase.dart';
import '../../entities/booking_entity.dart';
import '../../repositories/booking_repository.dart';

class GetUserBookingsUseCase implements UseCase<List<BookingEntity>, NoParams> {
  final BookingRepository repository;

  GetUserBookingsUseCase(this.repository);

  @override
  Future<List<BookingEntity>> call(NoParams params) async {
    return await repository.getUserBookings();
  }
}
