import 'package:equatable/equatable.dart';

abstract class BookingsListEvent extends Equatable {
  const BookingsListEvent();

  @override
  List<Object> get props => [];
}

class GetUserBookingsEvent extends BookingsListEvent {}

class CancelBookingEvent extends BookingsListEvent {
  final String bookingId;

  const CancelBookingEvent(this.bookingId);

  @override
  List<Object> get props => [bookingId];
}
