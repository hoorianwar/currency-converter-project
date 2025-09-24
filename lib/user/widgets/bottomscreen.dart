import 'package:flutter/material.dart';

class Bottomscreen extends StatelessWidget {
  const Bottomscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: theme.bottomNavigationBarTheme.backgroundColor ?? colorScheme.surface,
      selectedItemColor: theme.bottomNavigationBarTheme.selectedItemColor ?? colorScheme.primary,
      unselectedItemColor: theme.bottomNavigationBarTheme.unselectedItemColor ?? colorScheme.onSurfaceVariant,
      onTap: (value) {
        if (value == 0) {
          Navigator.pushReplacementNamed(context, "/userhome");
        } else if (value == 1) {
          Navigator.pushReplacementNamed(context, "/currencyconversion");
        } else if (value == 2) {
          // Navigator.pushReplacementNamed(context, "/userexchangerate");
        } else if (value == 3) {
          Navigator.pushReplacementNamed(context, "/usermarkettrend");
        }
      },
      elevation: 0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, size: 28),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.compare_arrows, size: 28),
          label: "Conversion",
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.currency_exchange, size: 28),
        //   label: "Rates",
        // ),
        BottomNavigationBarItem(
          icon: Icon(Icons.trending_up, size: 28),
          label: "Trends",
        ),
      ],
    );
  }
}
