import 'package:flutter/material.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              "Maria Irfan",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            accountEmail: Text(
              "mariairafan@gmail.com",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage("assets/images/user.png"),
              radius: 40,
            ),
          ),

          _buildDrawerItem(
            context,
            icon: Icons.dashboard,
            title: 'Dashboard',
            onTap: () => Navigator.pushReplacementNamed(context, "/admindashboard"),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.group,
            title: 'Manage Users',
            onTap: () => Navigator.pushReplacementNamed(context, "/ManageUsers"),
          ),
          // _buildDrawerItem(
          //   context,
          //   icon: Icons.attach_money,
          //   title: 'Currency List',
          //   onTap: () => Navigator.pushReplacementNamed(context, "/currencylist"),
          // ),
          // _buildDrawerItem(
          //   context,
          //   icon: Icons.currency_exchange,
          //   title: 'Exchange Rate Info',
          //   onTap: () => Navigator.pushReplacementNamed(context, "/exchangerate"),
          // ),
          // _buildDrawerItem(
          //   context,
          //   icon: Icons.history,
          //   title: 'Users History',
          //   onTap: () => Navigator.pushReplacementNamed(context, "/UserHistory"),
          // ),
          // _buildDrawerItem(
          //   context,
          //   icon: Icons.newspaper,
          //   title: 'Currency News',
          //   onTap: () => Navigator.pushReplacementNamed(context, "/CurrencyNews"),
          // ),
          _buildDrawerItem(
            context,
            icon: Icons.feedback,
            title: 'User Feedback',
            onTap: () => Navigator.pushReplacementNamed(context, "/UserFeedback"),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.settings,
            title: 'Settings',
            onTap: () => Navigator.pushReplacementNamed(context, "/Settings"),
          ),

          const Divider(),

          _buildDrawerItem(
            context,
            icon: Icons.logout,
            title: 'Logout',
            onTap: () {
              Navigator.pushReplacementNamed(context, "/login");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).iconTheme.color),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      onTap: onTap,
    );
  }
}
