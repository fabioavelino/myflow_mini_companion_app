import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myflow_mini_companion_app/cubits/training/training_cubit.dart';
import 'package:myflow_mini_companion_app/ui/widgets/training_card.dart';

class TrainingListScreen extends StatelessWidget {
  const TrainingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Last Trainings'),
        centerTitle: false,
      ),
      body: BlocBuilder<TrainingCubit, TrainingState>(
        builder: (context, state) {
          if (state is TrainingLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TrainingError) {
            return Center(
              child: Text('Error: ${state.message}'),
            );
          } else if (state is TrainingLoaded) {
            final trainings = state.trainings.take(3).toList();

            if (trainings.isEmpty) {
              return const Center(
                child: Text('No trainings available'),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: trainings.length,
              itemBuilder: (context, index) {
                final training = trainings[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: TrainingCard(
                    date: training.date,
                    mood: training.mood,
                    score: training.getScoreAsString(),
                    showHeader: false,
                  ),
                );
              },
            );
          }

          return const Center(child: Text('No data'));
        },
      ),
    );
  }
}
