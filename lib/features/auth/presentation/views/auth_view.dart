import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/constants/locale_keys.dart';
import 'package:the_project/features/main/presentation/views/main_view.dart';
import '../../../../core/components/arena_button.dart';
import '../../../../core/components/arena_text_field.dart';
import '../bloc/auth_bloc.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthViewContent();
  }
}

class AuthViewContent extends StatefulWidget {
  const AuthViewContent({super.key});

  @override
  State<AuthViewContent> createState() => _AuthViewContentState();
}

class _AuthViewContentState extends State<AuthViewContent> {
  bool isLogin = true;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    if (isLogin) {
      context.read<AuthBloc>().add(
        LoginSubmitted(
          email: emailController.text.trim(),
          password: passwordController.text,
        ),
      );
    } else {
      if (passwordController.text != confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Passwords do not match.')),
        );
        return;
      }
      context.read<AuthBloc>().add(
        RegisterSubmitted(
          name: nameController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const MainView()),
          );
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "You don't have an account ${state.message}",
              ), //state.message
              backgroundColor: Colors.red.shade700,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return Form(
                    key: _formKey,
                    child:
                        Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const SizedBox(height: 48),
                                Text(
                                  LocaleKeys.arena.tr(),
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.displayLarge?.copyWith(
                                    letterSpacing: -1,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  isLogin ? LocaleKeys.welcome_back.tr().toUpperCase() : LocaleKeys.sign_up_title.tr().toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    letterSpacing: 2,
                                    fontWeight: FontWeight.w600,
                                    color: theme.colorScheme.onSurface
                                        .withValues(alpha: 0.6),
                                  ),
                                ),
                                const SizedBox(height: 40),

                                // ── Name field (sign-up only) ──────────────────
                                if (!isLogin) ...[
                                  ArenaTextField(
                                        label: LocaleKeys.full_name.tr(),
                                        hintText: LocaleKeys.full_name.tr(),
                                        controller: nameController,
                                        prefixIcon: const Icon(
                                          Icons.person_outline,
                                        ),
                                        validator: (v) =>
                                            (v == null || v.trim().isEmpty)
                                            ? 'Name is required'
                                            : null,
                                      )
                                      .animate()
                                      .fadeIn(
                                        duration: 400.ms,
                                        curve: Curves.easeOut,
                                      )
                                      .slideY(begin: -0.1, end: 0),
                                  const SizedBox(height: 16),
                                ],

                                // ── Email ──────────────────────────────────────
                                ArenaTextField(
                                  label: LocaleKeys.email.tr(),
                                  hintText: 'your@email.com',
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  prefixIcon: const Icon(Icons.mail_outline),
                                  validator: (v) {
                                    if (v == null || v.trim().isEmpty) {
                                      return 'Email is required';
                                    }
                                    if (!v.contains('@')) {
                                      return 'Enter a valid email';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),

                                // ── Password ───────────────────────────────────
                                ArenaTextField(
                                  label: LocaleKeys.password.tr(),
                                  hintText: '••••••••',
                                  controller: passwordController,
                                  obscureText: true,
                                  prefixIcon: const Icon(Icons.lock_outline),
                                  validator: (v) {
                                    if (v == null || v.isEmpty) {
                                      return 'Password is required';
                                    }
                                    if (!isLogin && v.length < 6) {
                                      return 'Minimum 6 characters';
                                    }
                                    return null;
                                  },
                                ),

                                // ── Confirm Password (sign-up only) ────────────
                                if (!isLogin) ...[
                                  const SizedBox(height: 16),
                                  ArenaTextField(
                                        label: 'Confirm Password',
                                        hintText: '••••••••',
                                        controller: confirmPasswordController,
                                        obscureText: true,
                                        prefixIcon: const Icon(
                                          Icons.lock_outline,
                                        ),
                                        validator: (v) {
                                          if (v == null || v.isEmpty) {
                                            return 'Please confirm your password';
                                          }
                                          return null;
                                        },
                                      )
                                      .animate()
                                      .fadeIn(
                                        duration: 400.ms,
                                        curve: Curves.easeOut,
                                      )
                                      .slideY(begin: -0.1, end: 0),
                                ],

                                // ── Forgot password (sign-in only) ─────────────
                                if (isLogin) ...[
                                  const SizedBox(height: 8),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      onPressed: () {},
                                      style: TextButton.styleFrom(
                                        foregroundColor: theme
                                            .colorScheme
                                            .onSurface
                                            .withValues(alpha: 0.6),
                                        padding: EdgeInsets.zero,
                                        minimumSize: const Size(0, 0),
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                      ),
                                      child: Text(
                                        'Forgot password?',
                                        style: theme.textTheme.bodySmall,
                                      ),
                                    ),
                                  ),
                                ],

                                const SizedBox(height: 32),
                                ArenaButton(
                                  text: isLogin ? LocaleKeys.sign_in.tr().toUpperCase() : LocaleKeys.sign_up.tr().toUpperCase(),
                                  onPressed: _handleSubmit,
                                  isLoading: state is AuthLoading,
                                ),
                                const SizedBox(height: 32),

                                // ── Toggle sign-in / sign-up ───────────────────
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      isLogin
                                          ? LocaleKeys.dont_have_account.tr()
                                          : LocaleKeys.already_have_account.tr(),
                                      style: theme.textTheme.bodyMedium
                                          ?.copyWith(
                                            color: theme.colorScheme.onSurface
                                                .withValues(alpha: 0.6),
                                          ),
                                    ),
                                    GestureDetector(
                                      onTap: () => setState(() {
                                        isLogin = !isLogin;
                                        _formKey.currentState?.reset();
                                      }),
                                      child: Text(
                                        isLogin ? 'Sign up' : 'Sign in',
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                              color:
                                                  theme.colorScheme.onSurface,
                                              decoration:
                                                  TextDecoration.underline,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 48),
                              ],
                            )
                            .animate()
                            .fadeIn(duration: 500.ms, curve: Curves.easeOut)
                            .slideY(begin: 0.1, end: 0),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
