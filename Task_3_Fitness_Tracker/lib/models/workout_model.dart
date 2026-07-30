class Workout {
  final int? id;
  final String title;
  final int durationMinutes;
  final int calories;
  final int steps;
  final String date;

  Workout({
    this.id,
    required this.title,
    required this.durationMinutes,
    required this.calories,
    this.steps = 0,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'durationMinutes': durationMinutes,
      'calories': calories,
      'steps': steps,
      'date': date,
    };
  }

  factory Workout.fromMap(Map<String, dynamic> map) {
    return Workout(
      id: map['id'],
      title: map['title'],
      durationMinutes: map['durationMinutes'],
      calories: map['calories'],
      steps: map['steps'] ?? 0,
      date: map['date'],
    );
  }
}
