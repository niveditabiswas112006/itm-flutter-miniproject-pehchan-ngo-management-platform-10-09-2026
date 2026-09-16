import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/models/enums.dart';
import '../../shared/models/models.dart';
import '../../core/network/api_client.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Provide the current user state.
final authNotifierProvider = NotifierProvider<AuthNotifier, AppUser?>(() {
  return AuthNotifier();
});

final authStateProvider = Provider<AppUser?>((ref) {
  return ref.watch(authNotifierProvider);
});

class AuthNotifier extends Notifier<AppUser?> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  AppUser? build() {
    // Listen to auth state changes to auto-login/logout
    _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        _fetchAndSetUser(user);
      } else {
        state = null;
      }
    });
    return null;
  }

  Future<void> _fetchAndSetUser(User firebaseUser) async {
    try {
      final doc = await _firestore.collection('users').doc(firebaseUser.uid).get();
      if (doc.exists) {
        final data = doc.data()!;
        state = AppUser(
          id: firebaseUser.uid,
          name: data['name'] ?? firebaseUser.displayName ?? '',
          email: firebaseUser.email ?? '',
          phone: data['phone'] ?? '',
          profileImageUrl: data['profileImageUrl'] ?? '',
          role: _parseRole(data['role']),
          city: data['city'] ?? '',
          bio: data['bio'] ?? '',
          createdAt: data['createdAt'] != null ? (data['createdAt'] as Timestamp).toDate() : DateTime.now(),
        );
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> login(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        await _fetchAndSetUser(credential.user!);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      }
      throw Exception(e.message ?? 'Login failed');
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<void> register(String name, String email, String password, String role) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save additional details in Firestore
      if (credential.user != null) {
        await _firestore.collection('users').doc(credential.user!.uid).set({
          'name': name,
          'email': email,
          'role': role.toLowerCase(),
          'createdAt': FieldValue.serverTimestamp(),
          'phone': '',
          'profileImageUrl': '',
          'city': '',
          'bio': '',
        });
        
        // Fetch and set user immediately to update state
        await _fetchAndSetUser(credential.user!);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      }
      throw Exception(e.message ?? 'Registration failed');
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    state = null;
  }

  UserRole _parseRole(String? roleStr) {
    if (roleStr == 'admin') return UserRole.admin;
    if (roleStr == 'ngo') return UserRole.ngo;
    return UserRole.volunteer;
  }
}
