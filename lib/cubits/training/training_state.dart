part of 'training_cubit.dart';

sealed class TrainingState extends Equatable {
  const TrainingState();

  @override
  List<Object?> get props => [];
}

class TrainingInitial extends TrainingState {
  const TrainingInitial();
}

class TrainingLoading extends TrainingState {
  const TrainingLoading();
}

class TrainingLoaded extends TrainingState {
  final Training? lastTraining;
  final List<Training> trainings;

  const TrainingLoaded({
    this.lastTraining,
    this.trainings = const [],
  });

  @override
  List<Object?> get props => [lastTraining, trainings];
}

class TrainingError extends TrainingState {
  final String message;

  const TrainingError(this.message);

  @override
  List<Object?> get props => [message];
}
