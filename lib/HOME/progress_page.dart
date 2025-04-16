import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';


class ProgressPage extends StatelessWidget {
  final String selectedMonth;
  final List<String> weekLabels;
  final List<double> hydrationData;
  final List<double> walkingData;
  final List<double> runningData;
  final int stepsTaken;
  final int stepGoal;

  const ProgressPage({
    Key? key,
    required this.selectedMonth,
    required this.weekLabels,
    required this.hydrationData,
    required this.walkingData,
    required this.runningData,
    required this.stepsTaken,
    required this.stepGoal,
  }) : super(key: key);

  factory ProgressPage.mock() {
    return ProgressPage(
      selectedMonth: 'Apr',
      weekLabels: ['Week 1', 'Week 2', 'Week 3', 'Week 4'],
      hydrationData: [10000, 9000, 12000, 11000],
      walkingData: [80, 85, 90, 88],
      runningData: [70, 65, 72, 75],
      stepsTaken: 45000,
      stepGoal: 60000,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                selectedMonth,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            // Hydration Chart
            const Text(
              'Monthly Hydration Summary',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  barGroups: hydrationData.asMap().entries.map((entry) {
                    final index = entry.key;
                    final value = entry.value;
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(toY: value / 1000, color: Colors.blue, width: 16),
                      ],
                      showingTooltipIndicators: [0],
                    );
                  }).toList(),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) => Text(weekLabels[value.toInt()]),
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Monthly Walking & Running Summary',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  groupsSpace: 12,
                  barGroups: List.generate(4, (index) {
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(toY: walkingData[index].toDouble(), color: Colors.green, width: 8),
                        BarChartRodData(toY: runningData[index].toDouble(), color: Colors.orange, width: 8),
                      ],
                      showingTooltipIndicators: [0, 1],
                    );
                  }),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) => Text(weekLabels[value.toInt()]),
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Weekly Step & Calories Burn',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Steps Taken: $stepsTaken / $stepGoal'),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: stepsTaken / stepGoal,
              backgroundColor: Colors.grey[300],
              color: Colors.teal,
              minHeight: 20,
            ),
          ],
        ),
      ),
    );
  }
}
