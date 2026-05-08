import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/venue_entity.dart';
import '../../domain/repositories/favorites_repository.dart';
import '../models/venue_model.dart';

class SupabaseFavoritesRepositoryImpl implements FavoritesRepository {
  final SupabaseClient _client = Supabase.instance.client;

  @override
  Future<List<VenueEntity>> getFavorites() async {
    final user = _client.auth.currentUser;
    if (user == null) return [];

    try {
      // Fetch venue IDs favorited by the user
      final favoritesResponse = await _client
          .from('favorites')
          .select('venue_id')
          .eq('user_id', user.id);

      final List<String> venueIds = (favoritesResponse as List)
          .map((item) => item['venue_id'] as String)
          .toList();

      if (venueIds.isEmpty) return [];

      // Fetch full venue details for these IDs
      final venuesResponse = await _client
          .from('venues')
          .select()
          .inFilter('id', venueIds);

      return (venuesResponse as List)
          .map((json) => VenueModel.fromJson(json).toEntity())
          .toList();
    } catch (e) {
      print('DEBUG: Supabase getFavorites error: $e');
      return [];
    }
  }

  @override
  Future<void> toggleFavorite(VenueEntity venue) async {
    final user = _client.auth.currentUser;
    if (user == null) return;

    try {
      final isFav = await isFavorite(venue.id);
      if (isFav) {
        await _client
            .from('favorites')
            .delete()
            .eq('user_id', user.id)
            .eq('venue_id', venue.id);
      } else {
        await _client.from('favorites').insert({
          'user_id': user.id,
          'venue_id': venue.id,
        });
      }
    } catch (e) {
      print('DEBUG: Supabase toggleFavorite error: $e');
    }
  }

  @override
  Future<bool> isFavorite(String id) async {
    final user = _client.auth.currentUser;
    if (user == null) return false;

    try {
      final response = await _client
          .from('favorites')
          .select()
          .eq('user_id', user.id)
          .eq('venue_id', id)
          .maybeSingle();
      
      return response != null;
    } catch (e) {
      return false;
    }
  }
}
