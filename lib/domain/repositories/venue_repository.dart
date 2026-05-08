import '../entities/venue_entity.dart';
import '../entities/booking_entity.dart'; // contains TimeSlotEntity as well

abstract class VenueRepository {
  Future<List<VenueEntity>> getVenues();
  Future<VenueEntity> getVenueDetails(String id);
  Future<List<BookingEntity>> getBookings();
  Future<List<TimeSlotEntity>> getTimeSlots(String venueId, DateTime date);
}
