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
          Navigator.pushReplacementNamed(context, "/admindashboard");
        } else if (value == 1) {
          Navigator.pushReplacementNamed(context, "/currencylist");
        } else if (value == 2) {
          Navigator.pushReplacementNamed(context, "/CurrencyNews");
        } else if (value == 3) {
          // Navigator.pushReplacementNamed(context, "/exchangerate");
        }
      },
      elevation: 0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard, size: 28),
          label: "Dashboard",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.attach_money, size: 28),
          label: "Currency list",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.newspaper, size: 28),
          label: "Currency news",
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.currency_exchange, size: 28),
        //   label: "Rates",
        // ),
      ],
    );
  }
}
