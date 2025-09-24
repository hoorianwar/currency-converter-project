import 'package:currency_conversion/admin/widgets/drawer.dart';
import 'package:currency_conversion/admin/widgets/bottomscreen.dart';
import 'package:flutter/material.dart';


class ManageUsers extends StatelessWidget {
  const ManageUsers({super.key});

  @override
  Widget build(BuildContext context) {
 return Scaffold(
//  backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        // backgroundColor: const Color.fromARGB(255, 36, 3, 185),
        title: const Text('Admin Dashboard'),
      ),
      drawer: DrawerScreen(),
       body: SingleChildScrollView(),
       bottomNavigationBar: const Bottomscreen(),

  );
  }
}