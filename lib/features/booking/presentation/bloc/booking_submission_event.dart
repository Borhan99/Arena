import 'package:equatable/equatable.dart';
import '../../../../domain/entities/booking_entity.dart';

abstract class BookingSubmissionEvent extends Equatable {
  const BookingSubmissionEvent();

  @override
  List<Object> get props => [];
}

class SubmitBookingEvent extends BookingSubmissionEvent {
  final BookingEntity booking;

  const SubmitBookingEvent(this.booking);

  @override
  List<Object> get props => [booking];
}
