import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:the_project/core/di/injection_container.dart';
import 'package:the_project/domain/entities/booking_entity.dart';
import 'package:the_project/features/booking/presentation/views/booking_confirm_view.dart';
import 'package:the_project/features/booking/presentation/bloc/booking_submission_bloc.dart';
import 'package:the_project/features/booking/presentation/bloc/booking_submission_state.dart';
import 'package:the_project/features/booking/presentation/bloc/booking_submission_event.dart';
import 'dart:async';

class MockBookingSubmissionBloc extends Mock implements BookingSubmissionBloc {}

void main() {
  late MockBookingSubmissionBloc mockBloc;
  late BookingEntity tBooking;

  setUp(() {
    mockBloc = MockBookingSubmissionBloc();
    tBooking = const BookingEntity(
      id: '1',
      venueId: 'v1',
      venueName: 'Test Venue',
      venueImage: 'https://example.com/image.jpg',
      date: '2023-10-10',
      time: '10:00 AM',
      people: 5,
      totalPrice: 100.0,
      status: 'upcoming',
    );

    // Register the mock in sl
    sl.allowReassignment = true;
    sl.registerFactory<BookingSubmissionBloc>(() => mockBloc);

    // Stub necessary methods for Bloc
    when(() => mockBloc.state).thenReturn(BookingSubmissionInitial());
    when(() => mockBloc.stream).thenAnswer((_) => Stream.value(BookingSubmissionInitial()));
    when(() => mockBloc.close()).thenAnswer((_) async => {});
  });

  tearDown(() {
    sl.reset();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BookingConfirmView(booking: tBooking),
    );
  }

  testWidgets('should show success dialog when booking is successful', (tester) async {
    // arrange
    final controller = StreamController<BookingSubmissionState>();
    when(() => mockBloc.stream).thenAnswer((_) => controller.stream);
    when(() => mockBloc.state).thenReturn(BookingSubmissionInitial());

    await tester.pumpWidget(createWidgetUnderTest());

    // act: simulate success state
    controller.add(BookingSubmissionSuccess());
    await tester.pumpAndSettle();

    // assert
    expect(find.text('Booking Confirmed!'), findsOneWidget);
    expect(find.text('DONE'), findsOneWidget);
  });

  testWidgets('should call SubmitBookingEvent when confirm button is pressed', (tester) async {
    // arrange
    when(() => mockBloc.state).thenReturn(BookingSubmissionInitial());
    
    await tester.pumpWidget(createWidgetUnderTest());

    // act
    await tester.tap(find.text('CONFIRM BOOKING'));
    await tester.pump();

    // assert
    verify(() => mockBloc.add(any(that: isA<SubmitBookingEvent>()))).called(1);
  });
}
