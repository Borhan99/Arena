import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/venue_entity.dart';
import '../../domain/entities/booking_entity.dart';
import '../../domain/repositories/venue_repository.dart';
import '../models/venue_model.dart';
import '../models/time_slot_model.dart';

class SupabaseVenueRepositoryImpl implements VenueRepository {
  final SupabaseClient _client = Supabase.instance.client;

  @override
  Future<List<VenueEntity>> getVenues() async {
    try {
      final response = await _client.from('venues').select().order('name');

      return (response as List)
          .map((json) => VenueModel.fromJson(json).toEntity())
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch venues: $e');
    }
  }

  @override
  Future<VenueEntity> getVenueDetails(String id) async {
    try {
      final response = await _client
          .from('venues')
          .select()
          .eq('id', id)
          .single();

      return VenueModel.fromJson(response).toEntity();
    } catch (e) {
      throw Exception('Failed to fetch venue details: $e');
    }
  }

  @override
  Future<List<BookingEntity>> getBookings() async {
    // This might be for global bookings or admin view,
    // for user specific bookings see BookingRepository
    return [];
  }

  @override
  Future<List<TimeSlotEntity>> getTimeSlots(
    String venueId,
    DateTime date,
  ) async {
    try {
      final dateStr = date.toIso8601String().split('T')[0];

      // 1. Fetch existing bookings for this venue and date
      final bookingsResponse = await _client
          .from('bookings')
          .select('time')
          .eq('venue_id', venueId)
          .eq('date', dateStr)
          .neq('status', 'cancelled');

      final List<String> reservedTimes = (bookingsResponse as List)
          .map((item) => item['time'] as String)
          .toList();

      // 2. Fetch or generate slots
      List<TimeSlotEntity> slots;
      final slotsResponse = await _client
          .from('time_slots')
          .select()
          .eq('venue_id', venueId)
          .eq('date', dateStr);

      if ((slotsResponse as List).isNotEmpty) {
        slots = slotsResponse
            .map((json) => TimeSlotModel.fromJson(json).toEntity())
            .toList();
      } else {
        slots = _generateDefaultSlots(venueId, date);
      }

      // 3. Mark slots as unavailable if they are in reservedTimes
      return slots.map((slot) {
        if (reservedTimes.contains(slot.time)) {
          return TimeSlotEntity(
            id: slot.id,
            time: slot.time,
            available: false, // Mark as taken
            price: slot.price,
          );
        }
        return slot;
      }).toList();
    } catch (e) {
      return _generateDefaultSlots(venueId, date);
    }
  }

  List<TimeSlotEntity> _generateDefaultSlots(String venueId, DateTime date) {
    final List<TimeSlotEntity> slots = [];
    final hours = [9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21];

    for (var hour in hours) {
      final timeStr = "${hour.toString().padLeft(2, '0')}:00";
      slots.add(
        TimeSlotEntity(
          id: "${venueId}_${date.day}_$hour",
          time: timeStr,
          available: true,
          price: 0.0,
        ),
      );
    }
    return slots;
  }
}
