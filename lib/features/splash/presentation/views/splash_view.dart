import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_project/core/di/injection_container.dart';
import 'package:the_project/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:the_project/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:the_project/features/auth/presentation/views/auth_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  void _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 5));
    if (!mounted) return;

    final prefs = sl<SharedPreferences>();
    final isCompleted = prefs.getBool('onboarding_completed') ?? false;

    if (isCompleted) {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const AuthView()));
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<OnboardingBloc>(),
            child: const OnboardingView(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                  'Arena',
                  style: theme.textTheme.displayLarge?.copyWith(
                    letterSpacing: 3,
                    fontSize: 42,
                    color: theme.colorScheme.onSurface,
                  ),
                )
                .animate()
                .fadeIn(duration: 800.ms, curve: Curves.easeOut)
                .slideY(begin: 0.2, end: 0),
            const SizedBox(height: 12),
            Text(
                  'BOOK YOUR PERFECT SPACE',
                  style: theme.textTheme.bodySmall?.copyWith(
                    letterSpacing: 2,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                )
                .animate(delay: 800.ms)
                .fadeIn(duration: 1600.ms, curve: Curves.easeOut)
                .slideY(begin: 0.2, end: 0),
          ],
        ),
      ),
    );
  }
}
