import 'package:flutter_test/flutter_test.dart';
import 'package:the_project/data/models/venue_model.dart';
import 'package:the_project/domain/entities/venue_entity.dart';

void main() {
  group('VenueModel', () {
    final tVenueModel = VenueModel(
      id: '1',
      name: 'Arena 1',
      type: 'Football',
      images: ['image1.jpg'],
      location: 'City Center',
      pricePerHour: 50.0,
      capacity: 10,
      rating: 4.5,
      description: 'A great place to play football.',
      amenities: ['Parking', 'Water'],
      featured: true,
    );

    final tVenueJson = {
      'id': '1',
      'name': 'Arena 1',
      'type': 'Football',
      'images': ['image1.jpg'],
      'location': 'City Center',
      'price_per_hour': 50.0,
      'capacity': 10,
      'rating': 4.5,
      'description': 'A great place to play football.',
      'amenities': ['Parking', 'Water'],
      'featured': true,
    };

    test('fromJson should return a valid model', () {
      // act
      final result = VenueModel.fromJson(tVenueJson);
      // assert
      expect(result.id, tVenueModel.id);
      expect(result.name, tVenueModel.name);
      expect(result.pricePerHour, tVenueModel.pricePerHour);
    });

    test('fromJson should handle null fields with default values', () {
      // arrange
      final jsonWithNulls = {
        'id': '1',
        'name': 'Arena 1',
        'type': 'Football',
        'images': ['image1.jpg'],
        'location': 'City Center',
        'description': 'A great place to play football.',
        'amenities': ['Parking', 'Water'],
        // missing: price_per_hour, capacity, rating, featured
      };
      // act
      final result = VenueModel.fromJson(jsonWithNulls);
      // assert
      expect(result.pricePerHour, 0.0);
      expect(result.capacity, 0);
      expect(result.rating, 0.0);
      expect(result.featured, false);
    });

    test('toEntity should return a valid entity', () {
      // act
      final result = tVenueModel.toEntity();
      // assert
      expect(result, isA<VenueEntity>());
      expect(result.id, tVenueModel.id);
      expect(result.name, tVenueModel.name);
    });

    test('toJson should return a JSON map containing proper data', () {
      // act
      final result = tVenueModel.toJson();
      // assert
      expect(result['id'], tVenueModel.id);
      expect(result['price_per_hour'], tVenueModel.pricePerHour);
    });
  });
}
