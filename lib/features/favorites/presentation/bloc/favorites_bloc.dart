import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../domain/usecases/favorites/get_favorites_usecase.dart';
import '../../../../domain/usecases/favorites/toggle_favorite_usecase.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final GetFavoritesUseCase getFavoritesUseCase;
  final ToggleFavoriteUseCase toggleFavoriteUseCase;

  FavoritesBloc({
    required this.getFavoritesUseCase,
    required this.toggleFavoriteUseCase,
  }) : super(FavoritesInitial()) {
    on<GetFavoritesEvent>((event, emit) async {
      emit(FavoritesLoading());
      try {
        final favorites = await getFavoritesUseCase(NoParams());
        emit(FavoritesLoaded(favorites));
      } catch (e) {
        emit(FavoritesError(e.toString()));
      }
    });

    on<ToggleFavoriteEvent>((event, emit) async {
      try {
        await toggleFavoriteUseCase(event.venue);
        add(GetFavoritesEvent());
      } catch (e) {
        emit(FavoritesError(e.toString()));
      }
    });
  }
}
