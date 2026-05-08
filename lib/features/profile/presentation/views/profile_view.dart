import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/constants/locale_keys.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/views/auth_view.dart';
import 'settings_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Read the user from the nearest AuthBloc (provided at the app root
    // via SplashView / MainView chain).
    final authState = context.watch<AuthBloc>().state;
    final user = authState is Authenticated ? authState.user : null;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(LocaleKeys.settings.tr()),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsView()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // ── Avatar ──────────────────────────────────────────────────
            _buildAvatar(user?.avatarUrl, user?.initial ?? '?', theme)
                .animate()
                .scale(duration: 600.ms, curve: Curves.easeOutBack)
                .fadeIn(),
            const SizedBox(height: 16),

            // ── Display name ─────────────────────────────────────────────
            Text(
              user?.displayName ?? '—',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ).animate(delay: 200.ms).fadeIn().slideY(begin: 0.1, end: 0),

            // ── Email ────────────────────────────────────────────────────
            Text(
              user?.email ?? '—',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ).animate(delay: 300.ms).fadeIn(),
            const SizedBox(height: 32),

            // ── Stats row ─────────────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _StatItem(label: LocaleKeys.Bookings.tr(), value: '0'),
                const _StatItem(label: 'Rating', value: '—'),
                _StatItem(label: LocaleKeys.favorites.tr(), value: '0'),
              ],
            ).animate(delay: 400.ms).fadeIn().slideY(begin: 0.1, end: 0),
            const SizedBox(height: 48),

            // ── Menu ──────────────────────────────────────────────────────
            const _ProfileMenuTile(
              icon: Icons.person_outline,
              label: 'Edit Profile',
            ),
            const _ProfileMenuTile(
              icon: Icons.notifications_none,
              label: 'Notifications',
            ),
            const _ProfileMenuTile(
              icon: Icons.payment_outlined,
              label: 'Payment Methods',
            ),
            const _ProfileMenuTile(
              icon: Icons.help_outline,
              label: 'Help & Support',
            ),
            const SizedBox(height: 24),

            // ── Logout ────────────────────────────────────────────────────
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => _confirmLogout(context),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  LocaleKeys.logout.tr(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ).animate(delay: 600.ms).fadeIn(),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(String? avatarUrl, String initial, ThemeData theme) {
    if (avatarUrl != null && avatarUrl.isNotEmpty) {
      return CircleAvatar(
        radius: 50,
        backgroundImage: NetworkImage(avatarUrl),
        onBackgroundImageError: (_, __) {},
      );
    }
    return CircleAvatar(
      radius: 50,
      backgroundColor: theme.colorScheme.primary,
      child: Text(
        initial,
        style: theme.textTheme.headlineMedium?.copyWith(
          color: theme.colorScheme.onPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(LocaleKeys.logout.tr()),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(LocaleKeys.logout.tr()),
          ),
        ],
      ),
    ).then((confirmed) {
      if (confirmed == true && context.mounted) {
        context.read<AuthBloc>().add(LogoutRequested());
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const AuthView()),
          (_) => false,
        );
      }
    });
  }
}

// ─── Helpers ────────────────────────────────────────────────────────────────

class _StatItem extends StatelessWidget {
  final String label;
  final String value;

  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          value,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }
}

class _ProfileMenuTile extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ProfileMenuTile({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 20),
        ),
        title: Text(label, style: theme.textTheme.bodyLarge),
        trailing: const Icon(Icons.chevron_right, size: 20),
        onTap: () {},
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
