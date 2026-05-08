import '../../domain/entities/venue_entity.dart';
import '../../domain/entities/booking_entity.dart';
import '../../domain/repositories/venue_repository.dart';
import '../models/venue_model.dart';
import '../models/booking_model.dart';
import '../models/time_slot_model.dart';
import 'dart:math';

class MockVenueRepositoryImpl implements VenueRepository {
  @override
  Future<List<VenueEntity>> getVenues() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockVenues.map((e) => e.toEntity()).toList();
  }

  @override
  Future<VenueEntity> getVenueDetails(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockVenues.firstWhere((e) => e.id == id).toEntity();
  }

  @override
  Future<List<BookingEntity>> getBookings() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockBookings.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<TimeSlotEntity>> getTimeSlots(String venueId, DateTime date) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final slots = <TimeSlotModel>[];
    final hours = [
      "08:00", "09:00", "10:00", "11:00", "12:00", "13:00", "14:00",
      "15:00", "16:00", "17:00", "18:00", "19:00", "20:00", "21:00",
    ];
    final random = Random();
    for (int i = 0; i < hours.length; i++) {
      slots.add(TimeSlotModel(
        id: 'slot-$i',
        time: hours[i],
        available: random.nextDouble() > 0.3,
        price: 80.0 + random.nextInt(100),
      ));
    }
    return slots.map((e) => e.toEntity()).toList();
  }
}

// Data directly ported from venues.ts
final _mockVenues = [
  const VenueModel(
    id: "1",
    name: "Prime Basketball Arena",
    type: "basketball",
    images: [
      "https://images.unsplash.com/photo-1730106447145-fb3f8a2bcce1?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxtb2Rlcm4lMjBiYXNrZXRiYWxsJTIwY291cnQlMjBpbnRlcmlvcnxlbnwxfHx8fDE3NzYzNTQ0ODB8MA&ixlib=rb-4.1.0&q=80&w=1080",
      "https://images.unsplash.com/photo-1758813264940-e938213604de?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxmaXRuZXNzJTIwZ3ltJTIwc3BvcnRzJTIwY2VudGVyfGVufDF8fHx8MTc3NjM1NDQ4MXww&ixlib=rb-4.1.0&q=80&w=1080",
    ],
    location: "Downtown Sports Complex, 123 Main St",
    pricePerHour: 120,
    capacity: 50,
    rating: 4.8,
    description: "Professional-grade basketball court with wooden flooring, adjustable hoops, and stadium seating.",
    amenities: ["Changing Rooms", "Parking", "Air Conditioning", "Sound System", "Scoreboard"],
    featured: true,
  ),
  const VenueModel(
    id: "2",
    name: "Elite Football Stadium",
    type: "football",
    images: ["https://images.unsplash.com/photo-1718865886299-b2a39c8d1d6e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxpbmRvb3IlMjBmb290YmFsbCUyMHN0YWRpdW18ZW58MXx8fHwxNzc2MzU0NDgxfDA&ixlib=rb-4.1.0&q=80&w=1080"],
    location: "West Side Arena, 456 Oak Ave",
    pricePerHour: 180,
    capacity: 100,
    rating: 4.9,
    description: "Indoor football facility with premium turf, professional lighting, and spectator areas.",
    amenities: ["Locker Rooms", "Parking", "Cafe", "First Aid", "Equipment Rental"],
    featured: true,
  ),
  const VenueModel(
    id: "3",
    name: "Tennis Club Premium",
    type: "tennis",
    images: ["https://images.unsplash.com/photo-1658491830143-72808ca237e3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHx0ZW5uaXMlMjBjb3VydCUyMGluZG9vcnxlbnwxfHx8fDE3NzYzNTQ0ODF8MA&ixlib=rb-4.1.0&q=80&w=1080"],
    location: "East Tennis Center, 789 Court Rd",
    pricePerHour: 80,
    capacity: 20,
    rating: 4.7,
    description: "High-quality indoor tennis courts with professional surface, climate control, and coaching available.",
    amenities: ["Showers", "Parking", "Pro Shop", "Coaching", "Refreshments"],
    featured: false,
  ),
  const VenueModel(
    id: "4",
    name: "Aqua Sports Complex",
    type: "swimming",
    images: ["https://images.unsplash.com/photo-1680609989998-6183fcea718b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxzd2ltbWluZyUyMHBvb2wlMjBpbmRvb3J8ZW58MXx8fHwxNzc2MzU0NDgzfDA&ixlib=rb-4.1.0&q=80&w=1080"],
    location: "North Aquatic Center, 321 Pool Ln",
    pricePerHour: 150,
    capacity: 60,
    rating: 4.6,
    description: "Olympic-sized swimming pool with lane availability, diving boards, and professional timing systems.",
    amenities: ["Changing Rooms", "Showers", "Sauna", "Parking", "Lifeguard"],
    featured: true,
  ),
];

final _mockBookings = [
  const BookingModel(
    id: "b1",
    venueId: "1",
    venueName: "Prime Basketball Arena",
    venueImage: "https://images.unsplash.com/photo-1730106447145-fb3f8a2bcce1?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxtb2Rlcm4lMjBiYXNrZXRiYWxsJTIwY291cnQlMjBpbnRlcmlvcnxlbnwxfHx8fDE3NzYzNTQ0ODB8MA&ixlib=rb-4.1.0&q=80&w=1080",
    date: "2026-04-20",
    time: "14:00",
    people: 25,
    totalPrice: 120,
    status: "upcoming",
  ),
  const BookingModel(
    id: "b2",
    venueId: "4",
    venueName: "Aqua Sports Complex",
    venueImage: "https://images.unsplash.com/photo-1680609989998-6183fcea718b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxzd2ltbWluZyUyMHBvb2wlMjBpbmRvb3J8ZW58MXx8fHwxNzc2MzU0NDgzfDA&ixlib=rb-4.1.0&q=80&w=1080",
    date: "2026-04-10",
    time: "10:00",
    people: 15,
    totalPrice: 150,
    status: "past",
  ),
];
