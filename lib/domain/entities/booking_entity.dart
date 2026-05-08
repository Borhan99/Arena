import 'package:equatable/equatable.dart';

class TimeSlotEntity extends Equatable {
  final String id;
  final String time;
  final bool available;
  final double price;

  const TimeSlotEntity({
    required this.id,
    required this.time,
    required this.available,
    required this.price,
  });

  @override
  List<Object?> get props => [id, time, available, price];
}

class BookingEntity extends Equatable {
  final String id;
  final String venueId;
  final String venueName;
  final String venueImage;
  final String date;
  final String time;
  final int people;
  final double totalPrice;
  final String status; // upcoming, past, cancelled

  const BookingEntity({
    required this.id,
    required this.venueId,
    required this.venueName,
    required this.venueImage,
    required this.date,
    required this.time,
    required this.people,
    required this.totalPrice,
    required this.status,
  });

  @override
  List<Object?> get props => [
        id,
        venueId,
        venueName,
        venueImage,
        date,
        time,
        people,
        totalPrice,
        status,
      ];
}
