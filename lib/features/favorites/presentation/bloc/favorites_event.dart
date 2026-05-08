import 'package:equatable/equatable.dart';
import '../../../../domain/entities/venue_entity.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class GetFavoritesEvent extends FavoritesEvent {}

class ToggleFavoriteEvent extends FavoritesEvent {
  final VenueEntity venue;

  const ToggleFavoriteEvent(this.venue);

  @override
  List<Object> get props => [venue];
}
