import '../entities/venue_entity.dart';

abstract class FavoritesRepository {
  Future<List<VenueEntity>> getFavorites();
  Future<void> toggleFavorite(VenueEntity venue);
  Future<bool> isFavorite(String id);
}
