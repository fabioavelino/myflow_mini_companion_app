// training_repository.dart
import 'dart:convert';
import 'package:myflow_mini_companion_app/domain/models/training/training.dart';
import 'package:myflow_mini_companion_app/data/services/shared_preferences_service.dart';
import 'package:myflow_mini_companion_app/data/services/api_client_service.dart';

class TrainingRepository {
  static const String _trainingsKey = 'trainings_list';
  List<Training> _trainings = [];
  bool _isInitialized = false;
  final SharedPreferencesService _prefsService;
  final ApiClientService _apiClientService;

  TrainingRepository(this._prefsService, this._apiClientService);

  Future<void> _ensureInitialized() async {
    if (_isInitialized) return;
    
    await _loadTrainings();
    _isInitialized = true;
  }

  Future<void> _loadTrainings() async {
    final String? trainingsJson = await _prefsService.getString(_trainingsKey);
    if (trainingsJson != null && trainingsJson.isNotEmpty) {
      try {
        final List<dynamic> decoded = jsonDecode(trainingsJson);
        _trainings = decoded.map((json) => Training.fromJson(json)).toList();
      } catch (e) {
        _trainings = [];
      }
    }
  }

  Future<void> _saveTrainings() async {
    final String encoded = jsonEncode(
      _trainings.map((training) => training.toJson()).toList(),
    );
    await _prefsService.setString(_trainingsKey, encoded);
  }

  Future<Training?> getLastTraining() async {
    await _ensureInitialized();
    if (_trainings.isEmpty) return null;
    _trainings.sort((a, b) => b.date.compareTo(a.date));
    return _trainings.first;
  }

  Future<List<Training>> getTrainings() async {
    await _ensureInitialized();
    _trainings.sort((a, b) => b.date.compareTo(a.date));
    return List.unmodifiable(_trainings);
  }

  Future<void> addTraining(int mood, TrainingScore score) async {
    await _ensureInitialized();
    Training newTraining = Training(
      date: DateTime.now(),
      mood: mood,
      score: score,
    );
    _trainings.add(newTraining);
    await _saveTrainings();
    
    await _apiClientService.postTraining(newTraining.toJson());
  }

  Future<void> clearTrainings() async {
    await _ensureInitialized();
    _trainings.clear();
    await _prefsService.remove(_trainingsKey);
  }
}
