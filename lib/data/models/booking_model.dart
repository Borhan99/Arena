import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/booking_entity.dart';

part 'booking_model.g.dart';


@JsonSerializable(fieldRename: FieldRename.snake)
class BookingModel {
  const BookingModel({
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

  final String id;
  final String venueId;
  final String venueName;
  final String venueImage;
  final String date;
  final String time;
  final int people;
  final double totalPrice;
  final String status;

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return _$BookingModelFromJson({
      ...json,
      'total_price': json['total_price'] ?? 0.0,
      'people': json['people'] ?? 0,
    });
  }

  BookingEntity toEntity() {
    return BookingEntity(
      id: id,
      venueId: venueId,
      venueName: venueName,
      venueImage: venueImage,
      date: date,
      time: time,
      people: people,
      totalPrice: totalPrice,
      status: status,
    );
  }
}

