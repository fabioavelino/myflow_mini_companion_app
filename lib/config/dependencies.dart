import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myflow_mini_companion_app/cubits/user/user_cubit.dart';
import 'package:myflow_mini_companion_app/cubits/training/training_cubit.dart';
import 'package:myflow_mini_companion_app/data/repositories/user_repository.dart';
import 'package:myflow_mini_companion_app/data/repositories/training_repository.dart';
import 'package:myflow_mini_companion_app/data/services/shared_preferences_service.dart';
import 'package:myflow_mini_companion_app/data/services/api_client_service.dart';

class Dependencies extends StatelessWidget {
  final Widget child;

  const Dependencies({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final sharedPreferencesService = SharedPreferencesService();
    final apiClientService = ApiClientService();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserCubit(UserRepository())..loadUser(),
        ),
        BlocProvider(
          create: (context) => TrainingCubit(
            TrainingRepository(sharedPreferencesService, apiClientService),
          )..loadLastTraining(),
        ),
      ],
      child: child,
    );
  }
}
