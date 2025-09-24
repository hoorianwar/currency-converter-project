import 'package:flutter/material.dart';

class UserDrawer extends StatelessWidget {
  const UserDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); 

    return Drawer(
      backgroundColor: theme.drawerTheme.backgroundColor,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              "Maria Irfan",
              style: theme.textTheme.labelLarge,
            ),
            accountEmail: Text(
              "mariairfan@gmail.com",
              style: theme.textTheme.bodyMedium,
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage("assets/images/user.png"),
              radius: 40,
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF87CEFA), Color(0xFFE0F7FA)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          _buildDrawerItem(
            context,
            icon: Icons.home,
            title: 'Home',
            onTap: () => Navigator.pushReplacementNamed(context, "/userhome"),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.history,
            title: 'Users History',
            onTap: () => Navigator.pushReplacementNamed(context, "/userhistory"),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.notifications_active,
            title: 'Rate Alerts',
            onTap: () => Navigator.pushReplacementNamed(context, "/ratealerts"),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.support_agent,
            title: 'User Support',
            onTap: () => Navigator.pushReplacementNamed(context, "/support"),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.feedback,
            title: 'User Feedback',
            onTap: () => Navigator.pushReplacementNamed(context, "/feedback"),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.notifications,
            title: 'App Notification',
            onTap: () => Navigator.pushReplacementNamed(context, "/notifications"),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.settings,
            title: 'Settings',
            onTap: () => Navigator.pushReplacementNamed(context, "/usersettings"),
          ),

          const Divider(),

          _buildDrawerItem(
            context,
            icon: Icons.logout,
            title: 'Logout',
            onTap: () => Navigator.pushReplacementNamed(context, "/login"),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);

    return ListTile(
      leading: Icon(icon, color: theme.listTileTheme.iconColor),
      title: Text(title, style: theme.textTheme.labelLarge),
      onTap: onTap,
    );
  }
}
