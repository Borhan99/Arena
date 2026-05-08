import '../entities/booking_entity.dart';

abstract class BookingRepository {
  Future<List<BookingEntity>> getUserBookings();
  Future<void> submitBooking(BookingEntity booking);
  Future<void> cancelBooking(String bookingId);
}
