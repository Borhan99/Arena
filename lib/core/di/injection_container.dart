import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repositories/venue_repository.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../data/repositories/supabase_auth_repository_impl.dart';
import '../../domain/usecases/get_venues_usecase.dart';
import '../../domain/usecases/get_venue_details_usecase.dart';
import '../../domain/usecases/get_time_slots_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/check_auth_status_usecase.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../features/home/presentation/bloc/home_bloc.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../domain/repositories/favorites_repository.dart';
import '../../domain/usecases/favorites/get_favorites_usecase.dart';
import '../../domain/usecases/favorites/toggle_favorite_usecase.dart';
import '../../domain/usecases/favorites/check_favorite_status_usecase.dart';
import '../../domain/repositories/booking_repository.dart';
import '../../domain/usecases/booking/get_user_bookings_usecase.dart';
import '../../domain/usecases/booking/submit_booking_usecase.dart';
import '../../domain/usecases/booking/cancel_booking_usecase.dart';
import '../../features/favorites/presentation/bloc/favorites_bloc.dart';
import '../../features/onboarding/presentation/bloc/onboarding_bloc.dart';
import '../../features/booking/presentation/bloc/bookings_list_bloc.dart';
import '../../features/booking/presentation/bloc/booking_submission_bloc.dart';
import '../blocs/theme/theme_cubit.dart';
import '../../data/repositories/supabase_venue_repository_impl.dart';
import '../../data/repositories/supabase_booking_repository_impl.dart';
import '../../data/repositories/supabase_favorites_repository_impl.dart';
import 'package:hive/hive.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ── External ─────────────────────────────────────────────────────────────
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton<Box>(() => Hive.box('favorites'), instanceName: 'favoritesBox');
  sl.registerLazySingleton<Box>(() => Hive.box('settings'), instanceName: 'settingsBox');

  // ── BLoCs ─────────────────────────────────────────────────────────────────
  sl.registerFactory(() => ThemeCubit(sl(instanceName: 'settingsBox')));
  sl.registerFactory(() => HomeBloc(getVenuesUseCase: sl()));
  sl.registerFactory(
    () => AuthBloc(
      loginUseCase: sl(),
      registerUseCase: sl(),
      logoutUseCase: sl(),
      checkAuthStatusUseCase: sl(),
      getCurrentUserUseCase: sl(),
    ),
  );
  sl.registerFactory(() => OnboardingBloc(sharedPreferences: sl()));
  sl.registerFactory(
    () => FavoritesBloc(
      getFavoritesUseCase: sl(),
      toggleFavoriteUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => BookingsListBloc(
      getUserBookingsUseCase: sl(),
      cancelBookingUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => BookingSubmissionBloc(submitBookingUseCase: sl()),
  );

  // ── UseCases ──────────────────────────────────────────────────────────────
  sl.registerLazySingleton(() => GetVenuesUseCase(sl()));
  sl.registerLazySingleton(() => GetVenueDetailsUseCase(sl()));
  sl.registerLazySingleton(() => GetTimeSlotsUseCase(sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => CheckAuthStatusUseCase(sl()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(sl()));
  sl.registerLazySingleton(() => GetFavoritesUseCase(sl()));
  sl.registerLazySingleton(() => ToggleFavoriteUseCase(sl()));
  sl.registerLazySingleton(() => CheckFavoriteStatusUseCase(sl()));
  sl.registerLazySingleton(() => GetUserBookingsUseCase(sl()));
  sl.registerLazySingleton(() => SubmitBookingUseCase(sl()));
  sl.registerLazySingleton(() => CancelBookingUseCase(sl()));

  // ── Repositories ──────────────────────────────────────────────────────────
  sl.registerLazySingleton<VenueRepository>(() => SupabaseVenueRepositoryImpl());
  sl.registerLazySingleton<AuthRepository>(
    () => SupabaseAuthRepositoryImpl(),   // ← real Supabase auth
  );
  sl.registerLazySingleton<FavoritesRepository>(
    () => SupabaseFavoritesRepositoryImpl(),
  );
  sl.registerLazySingleton<BookingRepository>(() => SupabaseBookingRepositoryImpl());
}
