// api_client.dart
import 'package:dio/dio.dart';

class ApiClientService {
  final Dio _dio = Dio();

  Future<void> postTraining(Map<String, dynamic> trainingData) async {
    try {
      await _dio.post(
        'http://localhost:8080/training',
        data: trainingData,
      );
    } catch (e) {
      print('Error posting, server probably not running, training data: $e');
    }
  }
}
