// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';

// class RateChart extends StatelessWidget {
//   final List<FlSpot> data;

//   const RateChart({super.key, required this.data});

//   @override
//   Widget build(BuildContext context) {
//     return LineChart(
//       LineChartData(
//         borderData: FlBorderData(show: false),
//         gridData: FlGridData(show: false),
//         titlesData: FlTitlesData(show: false),
//         lineBarsData: [
//           LineChartBarData(
//             spots: data,
//             isCurved: true,
//             barWidth: 3,
//             color: Colors.lightBlue,
//             dotData: FlDotData(show: true),
//             belowBarData: BarAreaData(
//               show: true,
//               color: Colors.lightBlue.withOpacity(0.2),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
