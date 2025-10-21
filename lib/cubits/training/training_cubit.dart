import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myflow_mini_companion_app/domain/models/training/training.dart';
import 'package:myflow_mini_companion_app/data/repositories/training_repository.dart';

part 'training_state.dart';

// UI-specific enum for presentation layer
enum TrainingScoreUI {
  drowsy,
  optimal,
  stressed,
}

// Mapper extension
extension TrainingScoreUIMapper on TrainingScoreUI {
  TrainingScore toDomain() {
    switch (this) {
      case TrainingScoreUI.drowsy:
        return TrainingScore.drowsy;
      case TrainingScoreUI.optimal:
        return TrainingScore.optimal;
      case TrainingScoreUI.stressed:
        return TrainingScore.stressed;
    }
  }
}

class TrainingCubit extends Cubit<TrainingState> {
  final TrainingRepository _trainingRepository;

  TrainingCubit(this._trainingRepository) : super(const TrainingInitial());

  Future<void> loadLastTraining() async {
    try {
      emit(const TrainingLoading());
      final lastTraining = await _trainingRepository.getLastTraining();
      final trainings = await _trainingRepository.getTrainings();
      emit(TrainingLoaded(
        lastTraining: lastTraining,
        trainings: trainings,
      ));
    } catch (e) {
      emit(TrainingError(e.toString()));
    }
  }

  Future<void> loadAllTrainings() async {
    try {
      emit(const TrainingLoading());
      final trainings = await _trainingRepository.getTrainings();
      final lastTraining = trainings.isNotEmpty ? trainings.first : null;
      emit(TrainingLoaded(
        lastTraining: lastTraining,
        trainings: trainings,
      ));
    } catch (e) {
      emit(TrainingError(e.toString()));
    }
  }

  Future<void> addTraining(int mood, TrainingScore score) async {
    try {
      emit(const TrainingLoading());
      await _trainingRepository.addTraining(mood, score);
      await loadLastTraining();
    } catch (e) {
      emit(TrainingError(e.toString()));
    }
  }

  Future<void> clearTrainings() async {
    await _trainingRepository.clearTrainings();
    emit(const TrainingInitial());
  }
}
