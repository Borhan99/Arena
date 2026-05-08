import 'package:flutter_bloc/flutter_bloc.dart';
import 'main_navigation_event.dart';
import 'main_navigation_state.dart';

class MainNavigationBloc extends Bloc<MainNavigationEvent, MainNavigationState> {
  MainNavigationBloc() : super(const MainNavigationState()) {
    on<TabChanged>((event, emit) {
      emit(MainNavigationState(selectedIndex: event.index));
    });
  }
}
