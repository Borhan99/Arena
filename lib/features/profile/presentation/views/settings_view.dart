import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/blocs/theme/theme_cubit.dart';
import '../../../../core/constants/locale_keys.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(LocaleKeys.settings.tr()),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _SectionHeader(title: LocaleKeys.app_preferences.tr()),
          BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              return _SwitchTile(
                title: LocaleKeys.dark_mode.tr(),
                value: themeMode == ThemeMode.dark,
                onChanged: (v) {
                  context.read<ThemeCubit>().toggleTheme(v);
                },
              );
            },
          ),
          _MenuTile(
            title: LocaleKeys.language.tr(),
            subtitle: context.locale.languageCode == 'en'
                ? LocaleKeys.english.tr()
                : LocaleKeys.arabic.tr(),
            onTap: () {
              if (context.locale.languageCode == 'en') {
                context.setLocale(const Locale('ar'));
              } else {
                context.setLocale(const Locale('en'));
              }
            },
          ),
          _SwitchTile(
            title: LocaleKeys.push_notifications.tr(),
            value: true,
            onChanged: (v) {},
          ),
          _SwitchTile(
            title: LocaleKeys.email_updates.tr(),
            value: true,
            onChanged: (v) {},
          ),
          const SizedBox(height: 32),
          _SectionHeader(title: LocaleKeys.account_security.tr()),
          _MenuTile(title: LocaleKeys.change_password.tr(), onTap: () {}),
          _MenuTile(title: LocaleKeys.two_factor_auth.tr(), onTap: () {}),
          const SizedBox(height: 32),
          _SectionHeader(title: LocaleKeys.about.tr()),
          _MenuTile(title: LocaleKeys.privacy_policy.tr(), onTap: () {}),
          _MenuTile(title: LocaleKeys.terms_of_service.tr(), onTap: () {}),
          _MenuTile(
            title: LocaleKeys.app_version.tr(),
            subtitle: '1.0.0',
            onTap: null,
          ),
          _MenuTile(
            title:
                '                      ${LocaleKeys.app_developer.tr()} \n                            Borhan',
            onTap: () {
              launchUrl(
                Uri.parse('https://t.me/Borhan_almalek'),
                mode: LaunchMode.externalApplication,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          letterSpacing: 1.5,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
        ),
      ),
    );
  }
}

class _SwitchTile extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SwitchTile({
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
      contentPadding: EdgeInsets.zero,
      activeThumbColor: Theme.of(context).colorScheme.primary,
    );
  }
}

class _MenuTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;

  const _MenuTile({required this.title, this.subtitle, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: onTap != null
          ? const Icon(Icons.chevron_right, size: 20)
          : null,
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
    );
  }
}
