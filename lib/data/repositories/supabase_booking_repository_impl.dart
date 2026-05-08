import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/booking_entity.dart';
import '../../domain/repositories/booking_repository.dart';
import '../models/booking_model.dart';

class SupabaseBookingRepositoryImpl implements BookingRepository {
  final SupabaseClient _client = Supabase.instance.client;

  @override
  Future<List<BookingEntity>> getUserBookings() async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    try {
      final response = await _client
          .from('bookings')
          .select()
          .eq('user_id', user.id)
          .order('date', ascending: false);

      print('DEBUG: Supabase Bookings Response: $response');

      return (response as List)
          .map((json) => BookingModel.fromJson(json).toEntity())
          .toList();
    } catch (e) {
      print('DEBUG: Supabase Bookings Error: $e');
      throw Exception('Failed to fetch user bookings: $e');
    }
  }

  @override
  Future<void> submitBooking(BookingEntity booking) async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    try {
      final bookingData = {
        'id': booking.id,
        'user_id': user.id,
        'venue_id': booking.venueId,
        'venue_name': booking.venueName,
        'venue_image': booking.venueImage,
        'date': booking.date,
        'time': booking.time,
        'people': booking.people,
        'total_price': booking.totalPrice,
        'status': booking.status,
      };

      await _client.from('bookings').insert(bookingData);
    } catch (e) {
      throw Exception('Failed to submit booking: $e');
    }
  }

  @override
  Future<void> cancelBooking(String bookingId) async {
    try {
      await _client
          .from('bookings')
          .update({'status': 'cancelled'})
          .eq('id', bookingId);
    } catch (e) {
      throw Exception('Failed to cancel booking: $e');
    }
  }
}
