import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:the_project/features/auth/presentation/views/auth_view.dart';
import '../bloc/onboarding_bloc.dart';
import '../bloc/onboarding_event.dart';
import '../bloc/onboarding_state.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<OnboardingData> _onboardingPages = [
    OnboardingData(
      title: 'Instant Booking',
      description: 'Book your favorite sports courts in seconds with our real-time availability system.',
      icon: Icons.flash_on_rounded,
    ),
    OnboardingData(
      title: 'Favorites',
      description: 'Save your most-visited venues for quick access and faster reservations.',
      icon: Icons.favorite_rounded,
    ),
    OnboardingData(
      title: 'Management',
      description: 'Easily track, modify, or cancel your bookings all from a single dashboard.',
      icon: Icons.event_note_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<OnboardingBloc, OnboardingState>(
      listener: (context, state) {
        if (state.isCompleted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const AuthView()),
          );
        }
      },
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    context.read<OnboardingBloc>().add(PageChanged(index));
                  },
                  itemCount: _onboardingPages.length,
                  itemBuilder: (context, index) {
                    final data = _onboardingPages[index];
                    return Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(32),
                            ),
                            child: Icon(
                              data.icon,
                              size: 60,
                              color: theme.colorScheme.primary,
                            ),
                          )
                          .animate(key: ValueKey(index))
                          .scale(duration: 600.ms, curve: Curves.easeOutBack)
                          .fadeIn(),
                          const SizedBox(height: 48),
                          Text(
                            data.title,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.displaySmall?.copyWith(
                              fontWeight: FontWeight.w800,
                              letterSpacing: -1,
                            ),
                          ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),
                          const SizedBox(height: 16),
                          Text(
                            data.description,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                              height: 1.5,
                            ),
                          ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1, end: 0),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 48),
                child: Column(
                  children: [
                    BlocBuilder<OnboardingBloc, OnboardingState>(
                      builder: (context, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            _onboardingPages.length,
                            (index) => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              height: 8,
                              width: state.currentPage == index ? 24 : 8,
                              decoration: BoxDecoration(
                                color: state.currentPage == index
                                    ? theme.colorScheme.primary
                                    : theme.colorScheme.primary.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 48),
                    BlocBuilder<OnboardingBloc, OnboardingState>(
                      builder: (context, state) {
                        final isLastPage = state.currentPage == _onboardingPages.length - 1;
                        return SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {
                              if (isLastPage) {
                                context.read<OnboardingBloc>().add(CompleteOnboarding());
                              } else {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 600),
                                  curve: Curves.easeInOutCubic,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.primary,
                              foregroundColor: theme.colorScheme.onPrimary,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Text(
                              isLastPage ? 'Get Started' : 'Next',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingData {
  final String title;
  final String description;
  final IconData icon;

  OnboardingData({
    required this.title,
    required this.description,
    required this.icon,
  });
}
