import 'package:flutter/material.dart';
import 'package:myflow_mini_companion_app/ui/home/home_screen.dart';
import 'package:myflow_mini_companion_app/ui/training_session/list/training_list_screen.dart';
import 'package:myflow_mini_companion_app/ui/training_session/new/training_new_first_step_screen.dart';
import 'package:myflow_mini_companion_app/ui/training_session/new/training_new_second_step_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String trainingList = '/trainings';
  static const String trainingNewFirstStep = '/training/new/first-step';
  static const String trainingNewSecondStep = '/training/new/second-step';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => HomeScreen(),
      trainingList: (context) => TrainingListScreen(),
      trainingNewFirstStep: (context) => TrainingNewFirstStepScreen(),
      trainingNewSecondStep: (context) => TrainingNewSecondStepScreen(),
    };
  }
}
