import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myflow_mini_companion_app/config/routes.dart';
import 'package:myflow_mini_companion_app/cubits/user/user_cubit.dart';
import 'package:myflow_mini_companion_app/ui/widgets/primary_button.dart';

class TrainingNewFirstStepScreen extends StatefulWidget {
  const TrainingNewFirstStepScreen({super.key});

  @override
  State<TrainingNewFirstStepScreen> createState() =>
      _TrainingNewFirstStepScreenState();
}

class _TrainingNewFirstStepScreenState
    extends State<TrainingNewFirstStepScreen> {
  double _sliderValue = 1;

  void _onSliderChanged(double value) {
    if (value.round() != _sliderValue.round()) {
      HapticFeedback.selectionClick();
    }
    setState(() {
      _sliderValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New training'),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Title added here
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              return Text(
                    "${state is UserLoaded ? state.user.name : "User"}, how is your mood today ?",
                    style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              )
                  );
            })
          ),
          Expanded(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RotatedBox(
                      quarterTurns: 3,
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          trackHeight: 5,
                          thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 20,
                          ),
                          activeTrackColor: Theme.of(context).colorScheme.primary,
                          inactiveTrackColor: Colors.grey.shade300,
                          thumbColor: Theme.of(context).colorScheme.primary,
                          showValueIndicator: ShowValueIndicator.never,
                        ),
                        child: Slider(
                          value: _sliderValue,
                          min: 1,
                          max: 10,
                          divisions: 9,
                          label: _sliderValue.round().toString(),
                          onChanged: _onSliderChanged,
                        ),
                      ),
                    ),
                  const SizedBox(width: 16),
                  // Tick marks
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(10, (index) {
                      final value = 10 - index;
                      final isSelected = _sliderValue.round() == value;
                      return Expanded(
                        child: Center(
                          child: Container(
                            width: 12,
                            height: 3,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(width: 8),
                  // Labels
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(10, (index) {
                      final value = 10 - index;
                      final isSelected = _sliderValue.round() == value;
                      String label = '$value';
                      if (value == 10) {
                        label += ' (Excellent)';
                      } else if (value == 5) {
                        label += ' (Average)';
                      } else if (value == 1) {
                        label += ' (Very bad)';
                      }
                      return Expanded(
                        child: Center(
                          child: Text(
                            label,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: label.isNotEmpty
                                  ? isSelected ?  Theme.of(context).colorScheme.primary
                                  : Colors.black38
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(width: 32),
                ],
              ),
            ),
          ),
          PrimaryButton(
            label: "Next",
            onPressed: () {
              HapticFeedback.mediumImpact();
              Navigator.pushNamed(
                context,
                AppRoutes.trainingNewSecondStep,
                arguments: _sliderValue.round(),
              );
            },
          ),
        ],
      ),
    );
  }
}
