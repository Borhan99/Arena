import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final SharedPreferences sharedPreferences;

  OnboardingBloc({required this.sharedPreferences}) : super(const OnboardingState()) {
    on<PageChanged>((event, emit) {
      emit(state.copyWith(currentPage: event.pageIndex));
    });

    on<CompleteOnboarding>((event, emit) async {
      await sharedPreferences.setBool('onboarding_completed', true);
      emit(state.copyWith(isCompleted: true));
    });
  }
}
