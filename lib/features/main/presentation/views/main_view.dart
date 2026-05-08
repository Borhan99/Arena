import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/constants/locale_keys.dart';
import '../bloc/main_navigation_bloc.dart';
import '../bloc/main_navigation_event.dart';
import '../bloc/main_navigation_state.dart';
import '../../../home/presentation/views/home_view.dart';
import '../../../booking/presentation/views/bookings_view.dart';
import '../../../favorites/presentation/views/favorites_view.dart';
import '../../../profile/presentation/views/profile_view.dart';

import 'package:the_project/core/di/injection_container.dart';
import 'package:the_project/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:the_project/features/favorites/presentation/bloc/favorites_event.dart';
import 'package:the_project/features/booking/presentation/bloc/bookings_list_bloc.dart';
import 'package:the_project/features/booking/presentation/bloc/bookings_list_event.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MainNavigationBloc()),
        BlocProvider(
          create: (context) => sl<FavoritesBloc>()..add(GetFavoritesEvent()),
        ),
        BlocProvider(
          create: (context) =>
              sl<BookingsListBloc>()..add(GetUserBookingsEvent()),
        ),
      ],
      child: const MainViewContent(),
    );
  }
}

class MainViewContent extends StatelessWidget {
  const MainViewContent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<MainNavigationBloc, MainNavigationState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: state.selectedIndex,
            children: const [
              HomeView(),
              BookingsView(),
              FavoritesView(),
              ProfileView(),
            ],
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 20,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      child: _NavButton(
                        index: 0,
                        icon: Icons.home_rounded,
                        label: LocaleKeys.arena.tr(),
                        isSelected: state.selectedIndex == 0,
                      ),
                    ),
                    Flexible(
                      child: _NavButton(
                        index: 1,
                        icon: Icons.calendar_today_rounded,
                        label: LocaleKeys.Bookings.tr(),
                        isSelected: state.selectedIndex == 1,
                      ),
                    ),
                    Flexible(
                      child: _NavButton(
                        index: 2,
                        icon: Icons.favorite_rounded,
                        label: LocaleKeys.favorites.tr(),
                        isSelected: state.selectedIndex == 2,
                      ),
                    ),
                    Flexible(
                      child: _NavButton(
                        index: 3,
                        icon: Icons.person_rounded,
                        label: LocaleKeys.settings.tr(),
                        isSelected: state.selectedIndex == 3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _NavButton extends StatelessWidget {
  final int index;
  final IconData icon;
  final String label;
  final bool isSelected;

  const _NavButton({
    required this.index,
    required this.icon,
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        context.read<MainNavigationBloc>().add(TabChanged(index));
        if (index == 2) {
          context.read<FavoritesBloc>().add(GetFavoritesEvent());
        }
      },
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primary.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurface.withValues(alpha: 0.4),
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurface.withValues(alpha: 0.4),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
