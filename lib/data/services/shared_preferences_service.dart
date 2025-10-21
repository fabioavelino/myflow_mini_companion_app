// shared_preferences_service.dart
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  SharedPreferences? _prefs;
  bool _isInitialized = false;

  Future<void> _ensureInitialized() async {
    if (_isInitialized) return;
    _prefs = await SharedPreferences.getInstance();
    _isInitialized = true;
  }

  Future<String?> getString(String key) async {
    await _ensureInitialized();
    return _prefs?.getString(key);
  }

  Future<void> setString(String key, String value) async {
    await _ensureInitialized();
    await _prefs?.setString(key, value);
  }

  Future<void> remove(String key) async {
    await _ensureInitialized();
    await _prefs?.remove(key);
  }
}
