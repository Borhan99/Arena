import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:the_project/features/favorites/presentation/bloc/favorites_bloc.dart';
import '../../../../core/constants/locale_keys.dart';
import '../../../../core/components/arena_card.dart';
import '../../../../core/components/arena_text_field.dart';
import '../../../../core/di/injection_container.dart';
import '../bloc/home_bloc.dart';
import 'venue_details_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeBloc>()..add(GetVenuesEvent()),
      child: const HomeViewContent(),
    );
  }
}

class HomeViewContent extends StatefulWidget {
  const HomeViewContent({super.key});

  @override
  State<HomeViewContent> createState() => _HomeViewContentState();
}

class _HomeViewContentState extends State<HomeViewContent> {
  final TextEditingController _searchController = TextEditingController();

  final List<String> _venueTypes = [
    "all",
    "stadium",
    "hall",
    "football",
    "volleyball",
    "swimming",
    "gym",
    "badminton",
    "squash",
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    LocaleKeys.arena.tr(),
                    style: theme.textTheme.headlineLarge?.copyWith(
                      letterSpacing: -1,
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: theme.colorScheme.primary,
                    radius: 18,
                    child: Icon(
                      Icons.person,
                      color: theme.colorScheme.onPrimary,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ArenaTextField(
                controller: _searchController,
                hintText: LocaleKeys.search_venues.tr(),
                prefixIcon: const Icon(Icons.search),
                onSubmitted: (query) {
                  context.read<HomeBloc>().add(SearchVenuesEvent(query));
                },
              ),
            ),
            
            // Search Chips
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoaded && state.searchQuery.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                    child: Row(
                      children: [
                        Chip(
                          label: Text('"${state.searchQuery}"'),
                          onDeleted: () {
                            _searchController.clear();
                            context.read<HomeBloc>().add(const SearchVenuesEvent(''));
                          },
                          backgroundColor: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
                          labelStyle: theme.textTheme.labelMedium,
                          deleteIconColor: theme.colorScheme.primary,
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            const SizedBox(height: 16),

            // Filters
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                final selectedType = state is HomeLoaded
                    ? state.selectedType
                    : 'all';
                return SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _venueTypes.length,
                    itemBuilder: (context, index) {
                      final type = _venueTypes[index];
                      final isSelected = type == selectedType;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ChoiceChip(
                          label: Text(type.toUpperCase()),
                          selected: isSelected,
                          onSelected: (selected) {
                            if (selected) {
                              context.read<HomeBloc>().add(
                                FilterVenuesEvent(type),
                              );
                            }
                          },
                          labelStyle: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: isSelected
                                ? theme.colorScheme.onPrimary
                                : theme.colorScheme.onSurface,
                          ),
                          backgroundColor:
                              theme.colorScheme.surfaceContainerHighest,
                          selectedColor: theme.colorScheme.primary,
                          showCheckmark: false,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide.none,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 16),

            // Venues List
            Expanded(
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is HomeError) {
                    return Center(child: Text(state.message));
                  } else if (state is HomeLoaded) {
                    final venues = state.venues;
                    if (venues.isEmpty) {
                      return Center(
                        child: Text(
                          LocaleKeys.no_venues_found.tr(),
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.6,
                            ),
                          ),
                        ),
                      );
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      itemCount: venues.length,
                      itemBuilder: (context, index) {
                        final venue = venues[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child:
                              ArenaCard(
                                    imageUrl: venue.images.isNotEmpty
                                        ? venue.images.first
                                        : '',
                                    title: venue.name,
                                    location: venue.location,
                                    rating: venue.rating,
                                    type: venue.type,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => BlocProvider.value(
                                            value: context
                                                .read<FavoritesBloc>(),
                                            child: VenueDetailsView(
                                              venue: venue,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                  .animate()
                                  .fadeIn(
                                    duration: 400.ms,
                                    delay: (index * 100).ms,
                                  )
                                  .slideY(begin: 0.1, end: 0),
                        );
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
