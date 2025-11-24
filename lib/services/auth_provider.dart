import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  UserModel? _user;
  bool _isLoading = false;
  String? _errorMessage;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _user != null;

  AuthProvider() {
    _initAuthListener();
  }

  // Listen to auth state changes
  void _initAuthListener() {
    _authService.authStateChanges.listen((User? firebaseUser) async {
      if (firebaseUser != null) {
        _user = await _authService.getUserData(firebaseUser.uid);
      } else {
        _user = null;
      }
      notifyListeners();
    });
  }

  // Sign up
  Future<bool> signUp({
    required String email,
    required String password,
    String? displayName,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      _user = await _authService.signUpWithEmailPassword(
        email: email,
        password: password,
        displayName: displayName,
      );
      _setLoading(false);
      return _user != null;
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }

  // Sign in
  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      _user = await _authService.signInWithEmailPassword(
        email: email,
        password: password,
      );
      _setLoading(false);
      return _user != null;
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }

  // Sign out
  Future<void> signOut() async {
    _setLoading(true);
    try {
      await _authService.signOut();
      _user = null;
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // Reset password
  Future<bool> resetPassword(String email) async {
    _setLoading(true);
    _clearError();

    try {
      await _authService.resetPassword(email);
      _setLoading(false);
      return true;
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }

  // Update profile
  Future<bool> updateProfile({String? displayName}) async {
    _setLoading(true);
    _clearError();

    try {
      await _authService.updateUserProfile(displayName: displayName);
      if (_authService.currentUser != null) {
        _user = await _authService.getUserData(_authService.currentUser!.uid);
      }
      _setLoading(false);
      return true;
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }

  // Delete account
  Future<bool> deleteAccount() async {
    _setLoading(true);
    _clearError();

    try {
      await _authService.deleteAccount();
      _user = null;
      _setLoading(false);
      return true;
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void clearError() {
    _clearError();
  }
}
