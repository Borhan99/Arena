import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/booking_entity.dart'; // contains TimeSlotEntity

part 'time_slot_model.freezed.dart';
part 'time_slot_model.g.dart';

@freezed
abstract class TimeSlotModel with _$TimeSlotModel {
  const TimeSlotModel._();

  const factory TimeSlotModel({
    required String id,
    required String time,
    required bool available,
    required double price,
  }) = _TimeSlotModel;

  factory TimeSlotModel.fromJson(Map<String, dynamic> json) => _$TimeSlotModelFromJson(json);

  TimeSlotEntity toEntity() {
    return TimeSlotEntity(
      id: id,
      time: time,
      available: available,
      price: price,
    );
  }
}
