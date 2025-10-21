class Training {
  final DateTime date;
  final int mood;
  final TrainingScore score;

  Training({
    required this.date,
    required this.mood,
    required this.score,
  });

  factory Training.fromJson(Map<String, dynamic> json) {
    return Training(
      date: DateTime.parse(json['date']),
      mood: json['mood'],
      score: TrainingScore.values.byName(json['score']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'mood': mood,
      'score': score.name,
    };
  }

  String getScoreAsString() {
    return score.name;
  }
}

enum TrainingScore {
  drowsy,
  optimal,
  stressed,
}
