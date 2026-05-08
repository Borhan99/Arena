import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/components/arena_button.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../domain/entities/booking_entity.dart';
import '../../../main/presentation/views/main_view.dart';
import '../bloc/booking_submission_bloc.dart';
import '../bloc/booking_submission_event.dart';
import '../bloc/booking_submission_state.dart';

class BookingConfirmView extends StatelessWidget {
  final BookingEntity booking;

  const BookingConfirmView({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<BookingSubmissionBloc>(),
      child: BookingConfirmContent(booking: booking),
    );
  }
}

class BookingConfirmContent extends StatelessWidget {
  final BookingEntity booking;

  const BookingConfirmContent({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const serviceFee = 2.50;
    final totalAmount = booking.totalPrice + serviceFee;

    return BlocListener<BookingSubmissionBloc, BookingSubmissionState>(
      listener: (context, state) {
        if (state is BookingSubmissionSuccess) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.check_circle_outline_rounded, size: 80, color: Colors.green),
                  const SizedBox(height: 24),
                  Text(
                    'Booking Confirmed!',
                    style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Your reservation has been successfully placed. You can view it in your bookings.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  ArenaButton(
                    text: 'DONE',
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const MainView()),
                        (route) => false,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        } else if (state is BookingSubmissionError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        appBar: AppBar(
          title: const Text('Confirmation'),
          backgroundColor: theme.colorScheme.surface,
          elevation: 0,
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Summary Card
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: theme.colorScheme.onSurface.withValues(alpha: 0.1)),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  booking.venueImage,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      booking.venueName,
                                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '${booking.date} • ${booking.time}',
                                      style: theme.textTheme.bodySmall?.copyWith(
                                        color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Divider(),
                          ),
                          _PriceRow(label: 'Price', value: booking.totalPrice),
                          const SizedBox(height: 12),
                          const _PriceRow(label: 'Service Fee', value: serviceFee),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Divider(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Amount',
                                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '\$${totalAmount.toStringAsFixed(2)}',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ).animate().fadeIn().slideY(begin: 0.1, end: 0),
                    const SizedBox(height: 32),
                    Text(
                      'Booking Details',
                      style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                    ).animate(delay: 200.ms).fadeIn(),
                    const SizedBox(height: 16),
                    _DetailItem(icon: Icons.group_outlined, label: 'Players', value: '${booking.people} People'),
                    _DetailItem(icon: Icons.timer_outlined, label: 'Duration', value: '1 Hour'),
                    _DetailItem(icon: Icons.payments_outlined, label: 'Payment', value: 'At Venue'),
                  ],
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: BlocBuilder<BookingSubmissionBloc, BookingSubmissionState>(
                  builder: (context, state) {
                    return ArenaButton(
                      text: 'CONFIRM BOOKING',
                      isLoading: state is BookingSubmissionLoading,
                      onPressed: () {
                        context.read<BookingSubmissionBloc>().add(SubmitBookingEvent(booking));
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String label;
  final double value;

  const _PriceRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        Text(
          '\$${value.toStringAsFixed(2)}',
          style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class _DetailItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailItem({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: theme.colorScheme.primary, size: 20),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
              Text(
                value,
                style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    ).animate(delay: 300.ms).fadeIn().slideX(begin: 0.05, end: 0);
  }
}
