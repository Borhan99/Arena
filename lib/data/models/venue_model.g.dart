// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venue_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VenueModel _$VenueModelFromJson(Map<String, dynamic> json) => _VenueModel(
  id: json['id'] as String,
  name: json['name'] as String,
  type: json['type'] as String,
  images: (json['images'] as List<dynamic>).map((e) => e as String).toList(),
  location: json['location'] as String,
  pricePerHour: (json['price_per_hour'] as num).toDouble(),
  capacity: (json['capacity'] as num).toInt(),
  rating: (json['rating'] as num).toDouble(),
  description: json['description'] as String,
  amenities: (json['amenities'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  featured: json['featured'] as bool,
);

Map<String, dynamic> _$VenueModelToJson(_VenueModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'images': instance.images,
      'location': instance.location,
      'price_per_hour': instance.pricePerHour,
      'capacity': instance.capacity,
      'rating': instance.rating,
      'description': instance.description,
      'amenities': instance.amenities,
      'featured': instance.featured,
    };
