import 'package:equatable/equatable.dart';

class VenueEntity extends Equatable {
  final String id;
  final String name;
  final String type;
  final List<String> images;
  final String location;
  final double pricePerHour;
  final int capacity;
  final double rating;
  final String description;
  final List<String> amenities;
  final bool featured;

  const VenueEntity({
    required this.id,
    required this.name,
    required this.type,
    required this.images,
    required this.location,
    required this.pricePerHour,
    required this.capacity,
    required this.rating,
    required this.description,
    required this.amenities,
    required this.featured,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        type,
        images,
        location,
        pricePerHour,
        capacity,
        rating,
        description,
        amenities,
        featured,
      ];
}
