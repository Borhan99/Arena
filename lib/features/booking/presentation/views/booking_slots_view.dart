import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:the_project/domain/entities/venue_entity.dart';
import '../../../../core/components/arena_button.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../domain/repositories/venue_repository.dart';
import '../../../../domain/entities/booking_entity.dart'; // contains TimeSlotEntity
import 'booking_confirm_view.dart';

class BookingSlotsView extends StatefulWidget {
  final String venueId;
  const BookingSlotsView({super.key, required this.venueId});

  @override
  State<BookingSlotsView> createState() => _BookingSlotsViewState();
}

class _BookingSlotsViewState extends State<BookingSlotsView> {
  final VenueRepository _repository = sl<VenueRepository>();
  DateTime _selectedDate = DateTime.now();
  TimeSlotEntity? _selectedSlot;
  List<TimeSlotEntity> _timeSlots = [];
  bool _isLoading = true;
  VenueEntity? _venue;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    setState(() => _isLoading = true);
    try {
      _venue = await _repository.getVenueDetails(widget.venueId);
      final slots = await _repository.getTimeSlots(
        widget.venueId,
        _selectedDate,
      );
      if (mounted) {
        setState(() {
          _timeSlots = slots;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _loadTimeSlots() async {
    setState(() => _isLoading = true);
    try {
      final slots = await _repository.getTimeSlots(
        widget.venueId,
        _selectedDate,
      );
      if (mounted) {
        setState(() {
          _timeSlots = slots;
          _isLoading = false;
          _selectedSlot = null; // reset selection on day change
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _changeDate(int days) {
    setState(() {
      _selectedDate = _selectedDate.add(Duration(days: days));
    });
    _loadTimeSlots();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Generate week days starting from _selectedDate (or simple 7 days window)
    final today = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    final weekStart = _selectedDate.subtract(
      Duration(days: _selectedDate.weekday - 1),
    );
    final weekDays = List.generate(
      7,
      (index) => weekStart.add(Duration(days: index)),
    );

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: const Text('Select Time Slot'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date Selection Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Select Date', style: theme.textTheme.titleLarge),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.chevron_left),
                              onPressed: () => _changeDate(-7),
                            ),
                            Text(
                              '${DateFormat('MMM d').format(weekStart)} - ${DateFormat('MMM d').format(weekStart.add(const Duration(days: 6)))}',
                              style: theme.textTheme.bodyMedium,
                            ),
                            IconButton(
                              icon: const Icon(Icons.chevron_right),
                              onPressed: () => _changeDate(7),
                            ),
                          ],
                        ),
                      ],
                    ).animate().fadeIn().slideY(begin: 0.1, end: 0),

                    const SizedBox(height: 16),

                    // Date Grid
                    GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 7,
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8,
                              ),
                          itemCount: 7,
                          itemBuilder: (context, index) {
                            final day = weekDays[index];
                            final isSelected =
                                day.year == _selectedDate.year &&
                                day.month == _selectedDate.month &&
                                day.day == _selectedDate.day;
                            final isPast = day.isBefore(today);

                            return GestureDetector(
                              onTap: isPast
                                  ? null
                                  : () {
                                      setState(() {
                                        _selectedDate = day;
                                      });
                                      _loadTimeSlots();
                                    },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                decoration: BoxDecoration(
                                  color: isPast
                                      ? theme
                                            .colorScheme
                                            .surfaceContainerHighest
                                            .withValues(alpha: 0.5)
                                      : isSelected
                                      ? theme.colorScheme.primary
                                      : theme
                                            .colorScheme
                                            .surfaceContainerHighest,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      DateFormat('E').format(day).toUpperCase(),
                                      style: theme.textTheme.bodySmall
                                          ?.copyWith(
                                            color: isPast
                                                ? theme.colorScheme.onSurface
                                                      .withValues(alpha: 0.3)
                                                : isSelected
                                                ? theme.colorScheme.onPrimary
                                                : theme.colorScheme.onSurface,
                                          ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${day.day}',
                                      style: theme.textTheme.titleMedium
                                          ?.copyWith(
                                            color: isPast
                                                ? theme.colorScheme.onSurface
                                                      .withValues(alpha: 0.3)
                                                : isSelected
                                                ? theme.colorScheme.onPrimary
                                                : theme.colorScheme.onSurface,
                                            fontWeight: isSelected
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                        .animate(delay: 100.ms)
                        .fadeIn()
                        .slideY(begin: 0.1, end: 0),

                    const SizedBox(height: 32),

                    // Time Slots
                    Row(
                          children: [
                            const Icon(Icons.calendar_today, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              'Available Times',
                              style: theme.textTheme.titleLarge,
                            ),
                          ],
                        )
                        .animate(delay: 200.ms)
                        .fadeIn()
                        .slideY(begin: 0.1, end: 0),

                    const SizedBox(height: 16),

                    if (_isLoading)
                      const Center(child: CircularProgressIndicator())
                    else
                      GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 2.5,
                                  mainAxisSpacing: 12,
                                  crossAxisSpacing: 12,
                                ),
                            itemCount: _timeSlots.length,
                            itemBuilder: (context, index) {
                              final slot = _timeSlots[index];
                              final isSelected = _selectedSlot?.id == slot.id;

                              return GestureDetector(
                                onTap: slot.available
                                    ? () {
                                        setState(() => _selectedSlot = slot);
                                      }
                                    : null,
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  decoration: BoxDecoration(
                                    color: !slot.available
                                        ? theme
                                              .colorScheme
                                              .surfaceContainerHighest
                                              .withValues(alpha: 0.5)
                                        : isSelected
                                        ? theme.colorScheme.primary
                                        : theme
                                              .colorScheme
                                              .surfaceContainerHighest,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: isSelected
                                          ? theme.colorScheme.primary
                                          : Colors.transparent,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    slot.time,
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      color: !slot.available
                                          ? theme.colorScheme.onSurface
                                                .withValues(alpha: 0.3)
                                          : isSelected
                                          ? theme.colorScheme.onPrimary
                                          : theme.colorScheme.onSurface,
                                      decoration: !slot.available
                                          ? TextDecoration.lineThrough
                                          : null,
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                          .animate(delay: 300.ms)
                          .fadeIn()
                          .slideY(begin: 0.1, end: 0),

                    const SizedBox(
                      height: 100,
                    ), // Bottom padding for FAB/Bottom button
                  ],
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                border: Border(
                  top: BorderSide(color: theme.colorScheme.outlineVariant),
                ),
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_selectedSlot == null && !_isLoading)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          'Please select a time slot to continue',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.error,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ArenaButton(
                      text: 'CONTINUE',
                      onPressed: (_selectedSlot != null && _venue != null)
                          ? () {
                              final booking = BookingEntity(
                                id: DateTime.now().millisecondsSinceEpoch
                                    .toString(),
                                venueId: _venue!.id,
                                venueName: _venue!.name,
                                venueImage: _venue!.images.isNotEmpty
                                    ? _venue!.images.first
                                    : '',
                                date: DateFormat(
                                  'yyyy-MM-dd',
                                ).format(_selectedDate),
                                time: _selectedSlot!.time,
                                people: _venue!.capacity,
                                totalPrice: _venue!.pricePerHour,
                                status: 'pending',
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      BookingConfirmView(booking: booking),
                                ),
                              );
                            }
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
