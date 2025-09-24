// import 'package:flutter/material.dart';

// class InfoCard extends StatelessWidget {
//   final String title;
//   final String value;
//   final IconData icon;

//   const InfoCard({
//     super.key,
//     required this.title,
//     required this.value,
//     required this.icon,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.7),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, size: 40, color: Colors.lightBlue),
//           const SizedBox(height: 14),
//           Text(
//             title,
//             style: const TextStyle(
//                 color: Colors.black87,
//                 fontWeight: FontWeight.w600,
//                 fontSize: 14),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 6),
//           Text(
//             value,
//             style: const TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 26),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }
// }

