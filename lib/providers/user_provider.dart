import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  String? _email;
  bool _isLoggedIn = false;

  String? get email => _email;
  bool get isLoggedIn => _isLoggedIn;

  Future<void> loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    _email = prefs.getString('user_email');
    _isLoggedIn = _email != null;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) return false;
    _email = email;
    _isLoggedIn = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_email', email);
    notifyListeners();
    return true;
  }

  Future<bool> register(String email, String password) async {
    return await login(email, password);
  }

  Future<void> logout() async {
    _email = null;
    _isLoggedIn = false;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_email');
    notifyListeners();
  }
}
