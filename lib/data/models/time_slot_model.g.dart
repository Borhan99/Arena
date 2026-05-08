// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_slot_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TimeSlotModel _$TimeSlotModelFromJson(Map<String, dynamic> json) =>
    _TimeSlotModel(
      id: json['id'] as String,
      time: json['time'] as String,
      available: json['available'] as bool,
      price: (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$TimeSlotModelToJson(_TimeSlotModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'time': instance.time,
      'available': instance.available,
      'price': instance.price,
    };
