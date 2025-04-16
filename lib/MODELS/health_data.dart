class HealthData {
  final List<double> hydration;
  final List<List<double>> walkRun;
  final int currentSteps;
  final int goalSteps;

  HealthData({
    required this.hydration,
    required this.walkRun,
    required this.currentSteps,
    required this.goalSteps,
  });

  factory HealthData.fromJson(Map<String, dynamic> json) {
    return HealthData(
      hydration: List<double>.from(json['hydration']),
      walkRun: (json['walkRun'] as List)
          .map((item) => List<double>.from(item))
          .toList(),
      currentSteps: json['currentSteps'],
      goalSteps: json['goalSteps'],
    );
  }
}
