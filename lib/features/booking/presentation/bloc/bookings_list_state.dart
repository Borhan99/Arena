import 'package:equatable/equatable.dart';
import '../../../../domain/entities/booking_entity.dart';

abstract class BookingsListState extends Equatable {
  const BookingsListState();
  
  @override
  List<Object> get props => [];
}

class BookingsListInitial extends BookingsListState {}

class BookingsListLoading extends BookingsListState {}

class BookingsListLoaded extends BookingsListState {
  final List<BookingEntity> bookings;

  const BookingsListLoaded(this.bookings);

  @override
  List<Object> get props => [bookings];
}

class BookingsListError extends BookingsListState {
  final String message;

  const BookingsListError(this.message);

  @override
  List<Object> get props => [message];
}
