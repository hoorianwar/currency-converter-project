import 'package:flutter/material.dart';
import 'package:currency_conversion/user/widgets/drawer.dart';
import 'package:currency_conversion/user/widgets/bottomscreen.dart';

class MarketTrendScreen extends StatelessWidget {
  const MarketTrendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //  final themeProvider = Provider.of<ThemeProvider>(context);
     return Scaffold(
      // backgroundColor: const Color(0xFF121212), // Jet black
      appBar: AppBar(
        // backgroundColor: const Color(0xFFFCD535), // Binance Yellow
        title: const Text(
          'Currency Converter',
        
        ),
        centerTitle: true,
      ),
      drawer: UserDrawer(),
      body: Center(
      
      ),
      bottomNavigationBar: Bottomscreen(),
  );
}
}