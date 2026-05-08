import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../domain/usecases/booking/get_user_bookings_usecase.dart';
import '../../../../domain/usecases/booking/cancel_booking_usecase.dart';
import 'bookings_list_event.dart';
import 'bookings_list_state.dart';

class BookingsListBloc extends Bloc<BookingsListEvent, BookingsListState> {
  final GetUserBookingsUseCase getUserBookingsUseCase;
  final CancelBookingUseCase cancelBookingUseCase;

  BookingsListBloc({
    required this.getUserBookingsUseCase,
    required this.cancelBookingUseCase,
  }) : super(BookingsListInitial()) {
    on<GetUserBookingsEvent>((event, emit) async {
      emit(BookingsListLoading());
      try {
        final bookings = await getUserBookingsUseCase(NoParams());
        emit(BookingsListLoaded(bookings));
      } catch (e) {
        emit(BookingsListError(e.toString()));
      }
    });

    on<CancelBookingEvent>((event, emit) async {
      try {
        await cancelBookingUseCase(event.bookingId);
        add(GetUserBookingsEvent());
      } catch (e) {
        emit(BookingsListError(e.toString()));
      }
    });
  }
}
