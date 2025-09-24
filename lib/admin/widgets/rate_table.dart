// import 'package:flutter/material.dart';

// class RateTable extends StatelessWidget {
//   final List<Map<String, dynamic>> rates;

//   const RateTable({super.key, required this.rates});

//   @override
//   Widget build(BuildContext context) {
//     return DataTable(
//       columnSpacing: 16,
//       dataRowHeight: 40,
//       headingRowHeight: 40,
//       horizontalMargin: 12,
//       columns: const [
//         DataColumn(
//           label: Text(
//             'Currency',
//             style: TextStyle(
//               color: Colors.black54,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         DataColumn(
//           label: Text(
//             'Rate',
//             style: TextStyle(
//               color: Colors.black54,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ],
//       rows: rates
//           .map(
//             (rate) => DataRow(
//               cells: [
//                 DataCell(
//                   Text(
//                     rate['code'],
//                     style: const TextStyle(color: Colors.black),
//                   ),
//                 ),
//                 DataCell(
//                   Text(
//                     rate['rate'].toStringAsFixed(2),
//                     style: const TextStyle(
//                       color: Colors.lightBlue,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           )
//           .toList(),
//       headingRowColor: MaterialStateProperty.all(Colors.white),
//       dataRowColor: MaterialStateProperty.all(Colors.white.withOpacity(0.3)),
//       border: TableBorder(
//         horizontalInside: BorderSide(color: Colors.grey.shade300),
//       ),
//     );
//   }
// }
