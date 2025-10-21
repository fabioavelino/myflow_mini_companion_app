import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myflow_mini_companion_app/config/routes.dart';
import 'package:myflow_mini_companion_app/cubits/training/training_cubit.dart';
import 'package:myflow_mini_companion_app/ui/widgets/primary_button.dart';

class TrainingNewSecondStepScreen extends StatefulWidget {
  const TrainingNewSecondStepScreen({super.key});

  @override
  State<TrainingNewSecondStepScreen> createState() => _TrainingNewSecondStepScreenState();
}

class _TrainingNewSecondStepScreenState extends State<TrainingNewSecondStepScreen>
    with TickerProviderStateMixin {
  int _counter = 5;
  bool _isCountingDown = false;
  bool _isCompleted = false;
  TrainingScoreUI _selectedScore = TrainingScoreUI.drowsy;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late AnimationController _progressController;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );
    
    _progressController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  void _startCountdown() {
    if (_isCountingDown) return;

    setState(() {
      _isCountingDown = true;
      _counter = 5;
    });

    _progressController.forward();

    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (_counter > 0) {
        setState(() {
          _counter--;
        });
        return true;
      } else {
        var newSelectedScore = TrainingScoreUI.values[Random().nextInt(TrainingScoreUI.values.length)];
        setState(() {
          _isCompleted = true;
          _selectedScore = newSelectedScore;
        });
        _fadeController.forward();
        return false;
      }
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
            Padding(
        padding: const EdgeInsets.all(24.0),
        child: const Text(
              'Press start when you are ready for the assessment',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            )),
            const SizedBox(height: 40),
            Expanded(
              child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: _isCompleted
                      ? FadeTransition(
                          opacity: _fadeAnimation,
                          child: Text(
                            "Your score: ${_selectedScore.name}",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: _startCountdown,
                          child: SizedBox(
                            width: 200,
                            height: 200,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: 200,
                                  height: 200,
                                  child: AnimatedBuilder(
                                    animation: _progressController,
                                    builder: (context, child) {
                                      return CircularProgressIndicator(
                                        value: _progressController.value,
                                        strokeWidth: 8,
                                        backgroundColor: Colors.grey[300],
                                      );
                                    },
                                  ),
                                ),
                                Text(
                                  _isCountingDown
                                      ? '$_counter'
                                      : 'Start',
                                  style: TextStyle(
                                    fontSize: _isCountingDown ? 48 : 28,
                                    fontWeight: _isCountingDown ? FontWeight.bold : FontWeight.normal,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                ),
              ),
            ),
            PrimaryButton(
            label: "Save",
              onPressed: _isCompleted ? () {
                final mood = ModalRoute.of(context)!.settings.arguments as int;
                context.read<TrainingCubit>().addTraining(mood, _selectedScore.toDomain());
                Navigator.popUntil(context, ModalRoute.withName(AppRoutes.home));
              } : null,
            ),
          ],
      ),
    );
  }
}
