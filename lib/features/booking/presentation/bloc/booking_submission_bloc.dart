import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/usecases/booking/submit_booking_usecase.dart';
import 'booking_submission_event.dart';
import 'booking_submission_state.dart';

class BookingSubmissionBloc
    extends Bloc<BookingSubmissionEvent, BookingSubmissionState> {
  final SubmitBookingUseCase submitBookingUseCase;

  BookingSubmissionBloc({required this.submitBookingUseCase})
    : super(BookingSubmissionInitial()) {
    on<SubmitBookingEvent>((event, emit) async {
      emit(BookingSubmissionLoading());
      try {
        await submitBookingUseCase(event.booking);
        emit(BookingSubmissionSuccess());
      } catch (e) {
        emit(
          BookingSubmissionError(
            "This time is booked, please choose another time.",
          ),
        ); //e.toString()
      }
    });
  }
}
