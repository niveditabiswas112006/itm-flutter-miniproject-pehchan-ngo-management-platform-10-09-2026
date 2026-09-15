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
  // For local testing without backend, we store credentials in memory
  static final List<Map<String, dynamic>> _mockUsers = [
    {
      'email': 'volunteer@pehchan.org',
      'password': 'password123',
      'name': 'Demo Volunteer',
      'role': 'volunteer',
    },
  ];

  @override
  AppUser? build() {
    return null;
  }

  Future<void> login(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      // First try to match mock users
      final userMap = _mockUsers.firstWhere(
        (u) => u['email'] == email && u['password'] == password,
        orElse: () => <String, dynamic>{},
      );

      if (userMap.isNotEmpty) {
        state = AppUser(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          name: userMap['name'] ?? '',
          email: userMap['email'] ?? '',
          phone: '',
          profileImageUrl: '',
          role: _parseRole(userMap['role']),
          city: '',
          bio: '',
          createdAt: DateTime.now(),
        );
        return;
      }
      
      throw Exception('User not found or incorrect password');
    } catch (e) {
      print('Login error: $e');
      throw Exception('Login failed: $e');
    }
  }

  Future<void> register(String name, String email, String password, String role) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Check if user exists
    final exists = _mockUsers.any((u) => u['email'] == email);
    if (exists) {
      throw Exception('Email already in use');
    }

    _mockUsers.add({
      'email': email,
      'password': password,
      'name': name,
      'role': role.toLowerCase(),
    });

    // Auto login after registration
    await login(email, password);
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
