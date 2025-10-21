import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myflow_mini_companion_app/config/routes.dart';
import 'package:myflow_mini_companion_app/cubits/user/user_cubit.dart';
import 'package:myflow_mini_companion_app/cubits/training/training_cubit.dart';
import 'package:myflow_mini_companion_app/ui/widgets/training_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
          child: BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state is UserLoaded) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hello ${state.user.name} !",
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 16),
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: NetworkImage(state.user.picture),
                    ),
                  ],
                );
              } else if (state is UserLoading) {
                return const CircularProgressIndicator();
              } else if (state is UserError) {
                return Text('Error loading user: ${state.message}');
              }

              return const SizedBox.shrink();
            },
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 64.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => {
                Navigator.pushNamed(context, AppRoutes.trainingList),
              },
              child: BlocBuilder<TrainingCubit, TrainingState>(
                builder: (context, state) {
                  if (state is TrainingLoaded) {
                    return TrainingCard(
                      date: state.lastTraining?.date,
                      mood: state.lastTraining?.mood,
                      score: state.lastTraining?.getScoreAsString(),
                      showHeader: true,
                      headerTitle: 'Today training',
                      showSeeAll: true,
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.trainingList),
                    );
                  } else if (state is TrainingLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is TrainingError) {
                    return Text('Error loading training: ${state.message}');
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.trainingNewFirstStep);
          },
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: const CircleBorder(),
          child: const Icon(Icons.add, color: Colors.white, size: 32),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
