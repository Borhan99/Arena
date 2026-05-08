import '../../domain/entities/booking_entity.dart';
import '../../domain/repositories/booking_repository.dart';

class MockBookingRepositoryImpl implements BookingRepository {
  final List<BookingEntity> _mockBookings = [
    const BookingEntity(
      id: '1',
      venueId: '1',
      venueName: 'Elite Arena',
      venueImage: 'https://images.unsplash.com/photo-1546519638-68e109498ffc',
      date: '2026-05-10',
      time: '10:00 AM - 11:00 AM',
      people: 10,
      totalPrice: 25.0,
      status: 'confirmed',
    ),
    const BookingEntity(
      id: '2',
      venueId: '2',
      venueName: 'Green Court',
      venueImage: 'https://images.unsplash.com/photo-1551698618-1dfe5d97d256',
      date: '2026-05-12',
      time: '02:00 PM - 03:00 PM',
      people: 4,
      totalPrice: 15.0,
      status: 'confirmed',
    ),
    const BookingEntity(
      id: '3',
      venueId: '1',
      venueName: 'Elite Arena',
      venueImage: 'https://images.unsplash.com/photo-1546519638-68e109498ffc',
      date: '2026-04-20',
      time: '09:00 AM - 10:00 AM',
      people: 12,
      totalPrice: 25.0,
      status: 'completed',
    ),
  ];

  @override
  Future<List<BookingEntity>> getUserBookings() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return _mockBookings;
  }

  @override
  Future<void> submitBooking(BookingEntity booking) async {
    await Future.delayed(const Duration(seconds: 1));
    _mockBookings.insert(0, booking);
  }

  @override
  Future<void> cancelBooking(String bookingId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _mockBookings.removeWhere((b) => b.id == bookingId);
  }
}
