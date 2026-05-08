import 'package:equatable/equatable.dart';

abstract class BookingSubmissionState extends Equatable {
  const BookingSubmissionState();
  
  @override
  List<Object> get props => [];
}

class BookingSubmissionInitial extends BookingSubmissionState {}

class BookingSubmissionLoading extends BookingSubmissionState {}

class BookingSubmissionSuccess extends BookingSubmissionState {}

class BookingSubmissionError extends BookingSubmissionState {
  final String message;

  const BookingSubmissionError(this.message);

  @override
  List<Object> get props => [message];
}
