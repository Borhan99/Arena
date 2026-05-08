import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/venue_entity.dart';

part 'venue_model.freezed.dart';
part 'venue_model.g.dart';

@freezed
class VenueModel with _$VenueModel {
  const VenueModel._();

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory VenueModel({
    required String id,
    required String name,
    required String type,
    required List<String> images,
    required String location,
    required double pricePerHour,
    required int capacity,
    required double rating,
    required String description,
    required List<String> amenities,
    required bool featured,
  }) = _VenueModel;

  factory VenueModel.fromJson(Map<String, dynamic> json) {
    // Safely handle potential nulls from Supabase
    return _$VenueModelFromJson({
      ...json,
      'price_per_hour': json['price_per_hour'] ?? 0.0,
      'rating': json['rating'] ?? 0.0,
      'capacity': json['capacity'] ?? 0,
      'featured': json['featured'] ?? false,
    });
  }

  VenueEntity toEntity() {
    return VenueEntity(
      id: id,
      name: name,
      type: type,
      images: images,
      location: location,
      pricePerHour: pricePerHour,
      capacity: capacity,
      rating: rating,
      description: description,
      amenities: amenities,
      featured: featured,
    );
  }

  @override
  // TODO: implement amenities
  List<String> get amenities => throw UnimplementedError();

  @override
  // TODO: implement capacity
  int get capacity => throw UnimplementedError();

  @override
  // TODO: implement description
  String get description => throw UnimplementedError();

  @override
  // TODO: implement featured
  bool get featured => throw UnimplementedError();

  @override
  // TODO: implement id
  String get id => throw UnimplementedError();

  @override
  // TODO: implement images
  List<String> get images => throw UnimplementedError();

  @override
  // TODO: implement location
  String get location => throw UnimplementedError();

  @override
  // TODO: implement name
  String get name => throw UnimplementedError();

  @override
  // TODO: implement pricePerHour
  double get pricePerHour => throw UnimplementedError();

  @override
  // TODO: implement rating
  double get rating => throw UnimplementedError();

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }

  @override
  // TODO: implement type
  String get type => throw UnimplementedError();
}
