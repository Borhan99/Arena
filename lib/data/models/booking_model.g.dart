// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingModel _$BookingModelFromJson(Map<String, dynamic> json) => BookingModel(
  id: json['id'] as String,
  venueId: json['venue_id'] as String,
  venueName: json['venue_name'] as String,
  venueImage: json['venue_image'] as String,
  date: json['date'] as String,
  time: json['time'] as String,
  people: (json['people'] as num).toInt(),
  totalPrice: (json['total_price'] as num).toDouble(),
  status: json['status'] as String,
);

Map<String, dynamic> _$BookingModelToJson(BookingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'venue_id': instance.venueId,
      'venue_name': instance.venueName,
      'venue_image': instance.venueImage,
      'date': instance.date,
      'time': instance.time,
      'people': instance.people,
      'total_price': instance.totalPrice,
      'status': instance.status,
    };
