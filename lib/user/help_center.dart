import 'package:flutter/material.dart';
import 'package:currency_conversion/user/widgets/drawer.dart';
import 'package:currency_conversion/user/widgets/bottomscreen.dart';

class UserSupportScreen extends StatelessWidget {
  const UserSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Currency Converter',
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      drawer: UserDrawer(),
      body: Center(),
           bottomNavigationBar: Bottomscreen(),
  );
}
}