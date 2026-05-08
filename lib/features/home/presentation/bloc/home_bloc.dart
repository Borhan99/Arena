import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/entities/venue_entity.dart';
import '../../../../domain/usecases/get_venues_usecase.dart';
import '../../../../core/usecases/usecase.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetVenuesEvent extends HomeEvent {}

class FilterVenuesEvent extends HomeEvent {
  final String type;
  const FilterVenuesEvent(this.type);

  @override
  List<Object> get props => [type];
}

class SearchVenuesEvent extends HomeEvent {
  final String query;
  const SearchVenuesEvent(this.query);

  @override
  List<Object> get props => [query];
}

abstract class HomeState extends Equatable {
  const HomeState();
  
  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<VenueEntity> venues;
  final String selectedType;
  final String searchQuery;

  const HomeLoaded({
    required this.venues,
    this.selectedType = 'all',
    this.searchQuery = '',
  });

  @override
  List<Object?> get props => [venues, selectedType, searchQuery];
}

class HomeError extends HomeState {
  final String message;
  const HomeError(this.message);

  @override
  List<Object> get props => [message];
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetVenuesUseCase getVenuesUseCase;
  List<VenueEntity> _allVenues = [];

  HomeBloc({required this.getVenuesUseCase}) : super(HomeInitial()) {
    on<GetVenuesEvent>(_onGetVenues);
    on<FilterVenuesEvent>(_onFilterVenues);
    on<SearchVenuesEvent>(_onSearchVenues);
  }

  Future<void> _onGetVenues(GetVenuesEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      _allVenues = await getVenuesUseCase(NoParams());
      emit(HomeLoaded(venues: _allVenues));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  void _onFilterVenues(FilterVenuesEvent event, Emitter<HomeState> emit) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      final filtered = _applyFilters(event.type, currentState.searchQuery);
      emit(HomeLoaded(
        venues: filtered,
        selectedType: event.type,
        searchQuery: currentState.searchQuery,
      ));
    }
  }

  void _onSearchVenues(SearchVenuesEvent event, Emitter<HomeState> emit) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      final filtered = _applyFilters(currentState.selectedType, event.query);
      emit(HomeLoaded(
        venues: filtered,
        selectedType: currentState.selectedType,
        searchQuery: event.query,
      ));
    }
  }

  List<VenueEntity> _applyFilters(String type, String query) {
    return _allVenues.where((v) {
      final matchesType = type == 'all' || v.type == type;
      final matchesSearch = query.isEmpty ||
          v.name.toLowerCase().contains(query.toLowerCase()) ||
          v.location.toLowerCase().contains(query.toLowerCase());
      return matchesType && matchesSearch;
    }).toList();
  }
}
