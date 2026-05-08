import 'dart:convert';
import 'package:hive/hive.dart';
import '../../domain/entities/venue_entity.dart';
import '../../domain/repositories/favorites_repository.dart';
import '../models/venue_model.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final Box favoritesBox;

  FavoritesRepositoryImpl({required this.favoritesBox});

  @override
  Future<List<VenueEntity>> getFavorites() async {
    final List<VenueEntity> favorites = [];
    for (var key in favoritesBox.keys) {
      final jsonString = favoritesBox.get(key);
      if (jsonString != null) {
        final Map<String, dynamic> jsonMap = json.decode(jsonString);
        favorites.add(VenueModel.fromJson(jsonMap).toEntity());
      }
    }
    return favorites;
  }

  @override
  Future<void> toggleFavorite(VenueEntity venue) async {
    if (favoritesBox.containsKey(venue.id)) {
      await favoritesBox.delete(venue.id);
    } else {
      final model = VenueModel(
        id: venue.id,
        name: venue.name,
        type: venue.type,
        images: venue.images,
        location: venue.location,
        pricePerHour: venue.pricePerHour,
        capacity: venue.capacity,
        rating: venue.rating,
        description: venue.description,
        amenities: venue.amenities,
        featured: venue.featured,
      );
      await favoritesBox.put(venue.id, json.encode(model.toJson()));
    }
  }

  @override
  Future<bool> isFavorite(String id) async {
    return favoritesBox.containsKey(id);
  }
}
