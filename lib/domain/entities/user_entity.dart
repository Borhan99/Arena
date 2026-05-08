import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String? name;
  final String? avatarUrl;

  const UserEntity({
    required this.id,
    required this.email,
    this.name,
    this.avatarUrl,
  });

  /// Returns the display name or falls back to the email prefix.
  String get displayName => (name != null && name!.isNotEmpty)
      ? name!
      : email.split('@').first;

  /// Returns the first letter of the display name for avatar initials.
  String get initial => displayName.isNotEmpty
      ? displayName[0].toUpperCase()
      : '?';

  @override
  List<Object?> get props => [id, email, name, avatarUrl];
}
