import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/models/enums.dart';
import '../../shared/models/models.dart';
import '../../core/network/api_client.dart';

// Provide the current user state.
final authNotifierProvider = NotifierProvider<AuthNotifier, AppUser?>(() {
  return AuthNotifier();
});

final authStateProvider = Provider<AppUser?>((ref) {
  return ref.watch(authNotifierProvider);
});

class AuthNotifier extends Notifier<AppUser?> {
  @override
  AppUser? build() {
    return null;
  }

  Future<void> login(String email, String password) async {
    try {
      final response = await ApiClient.get('/users');
      final usersList = response['data'] as List;
      
      final userMap = usersList.firstWhere(
        (u) => u['email'] == email,
        orElse: () => null,
      );

      if (userMap != null) {
        state = AppUser(
          id: userMap['id'] ?? '',
          name: userMap['name'] ?? '',
          email: userMap['email'] ?? '',
          phone: userMap['phone'] ?? '',
          profileImageUrl: userMap['profileImageUrl'] ?? '',
          role: _parseRole(userMap['role']),
          city: userMap['city'] ?? '',
          bio: userMap['bio'] ?? '',
          createdAt: DateTime.tryParse(userMap['createdAt']?.toString() ?? '') ?? DateTime.now(),
        );
      } else {
        throw Exception('User not found');
      }
    } catch (e) {
      print('Login error: $e');
      throw Exception('Login failed: $e');
    }
  }

  void logout() {
    state = null;
  }

  UserRole _parseRole(String? roleStr) {
    if (roleStr == 'admin') return UserRole.admin;
    if (roleStr == 'ngo') return UserRole.ngo;
    return UserRole.volunteer;
  }
}
