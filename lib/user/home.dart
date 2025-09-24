import 'package:flutter/material.dart';
import 'package:currency_conversion/user/widgets/drawer.dart';
import 'package:currency_conversion/user/widgets/bottomscreen.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> with SingleTickerProviderStateMixin {
  final String welcomeText = "WELCOME";
  late AnimationController _controller;
  late List<Animation<double>> _fadeAnimations;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );

    _fadeAnimations = List.generate(welcomeText.length, (index) {
      final start = index / welcomeText.length;
      final end = (index + 1) / welcomeText.length;
      return Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(start, end, curve: Curves.easeIn),
        ),
      );
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth > 600;
    final cardWidth = isWide ? (screenWidth / 2) - 40 : screenWidth - 40;

    return Scaffold(
      appBar: AppBar(
        title: Text("Home", style: theme.textTheme.titleLarge),
        centerTitle: true,
        elevation: 3,
      ),
      drawer: const UserDrawer(),
      bottomNavigationBar: const Bottomscreen(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildAnimatedWelcome(theme),
            const SizedBox(height: 30),

            // Quick Conversion Box
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Quick Conversion", style: theme.textTheme.titleMedium),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("1 USD = ₹83.00", style: theme.textTheme.bodyMedium),
                        Icon(Icons.arrow_forward_ios, color: theme.iconTheme.color, size: 16),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text("Updated just now • Based on XE Market",
                        style: theme.textTheme.bodySmall),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Live Market Rates Cards
            Text("Live Market Rates", style: theme.textTheme.titleMedium),
            const SizedBox(height: 14),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _buildRateCard(theme, "EUR → USD", "1 EUR = 1.10 USD", "European Central Bank", cardWidth),
                _buildRateCard(theme, "GBP → JPY", "1 GBP = 185.30 JPY", "Bank of England", cardWidth),
                _buildRateCard(theme, "AUD → CAD", "1 AUD = 0.89 CAD", "Reserve Bank of Australia", cardWidth),
                _buildRateCard(theme, "BTC → USD", "1 BTC = \$27,500", "Binance Average", cardWidth),
              ],
            ),

            const SizedBox(height: 40),

            // Latest News Section
            Text("Latest Currency News", style: theme.textTheme.titleMedium),
            const SizedBox(height: 14),
            _buildNewsCard(theme,
                title: "USD strengthens against Euro amid market optimism",
                date: "Sep 1, 2025",
                snippet:
                    "The US Dollar showed strength today, driven by positive economic data and investor confidence..."),
            _buildNewsCard(theme,
                title: "Cryptocurrency markets see mixed trends",
                date: "Aug 31, 2025",
                snippet:
                    "Bitcoin and other major cryptocurrencies experienced fluctuations as regulatory news continues to impact..."),
            _buildNewsCard(theme,
                title: "Central banks to meet next week to discuss interest rates",
                date: "Aug 30, 2025",
                snippet:
                    "Major central banks including the Fed and ECB are scheduled to meet, signaling potential changes in monetary policies..."),

            const SizedBox(height: 40),

            // Conversion History
            Text("Recent Conversions", style: theme.textTheme.titleMedium),
            const SizedBox(height: 14),
            _buildConversionHistory(theme, "USD → INR", "₹83.00", "Today"),
            _buildConversionHistory(theme, "EUR → USD", "\$1.10", "Yesterday"),
            _buildConversionHistory(theme, "GBP → JPY", "¥185.30", "2 days ago"),

            const SizedBox(height: 40),

            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, "/currencyconversion");
                },
                icon: const Icon(Icons.swap_horiz),
                label: const Text("Convert Now"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedWelcome(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary,
                  theme.colorScheme.secondary,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.primary.withOpacity(0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(welcomeText.length, (index) {
                return AnimatedBuilder(
                  animation: _fadeAnimations[index],
                  builder: (context, child) {
                    return Opacity(
                      opacity: _fadeAnimations[index].value,
                      child: child,
                    );
                  },
                  child: Text(
                    welcomeText[index],
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                      color: Colors.white,
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        const SizedBox(height: 14),
        Text("Maria", style: theme.textTheme.titleLarge),
        const SizedBox(height: 4),
        Text("Manage your currency smartly in real-time.",
            style: theme.textTheme.bodyMedium),
      ],
    );
  }

  Widget _buildRateCard(
      ThemeData theme, String title, String rate, String source, double width) {
    return Card(
      child: Container(
        width: width,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(rate,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                )),
            const SizedBox(height: 4),
            Text(source, style: theme.textTheme.bodySmall),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsCard(ThemeData theme,
      {required String title, required String date, required String snippet}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: theme.textTheme.titleMedium),
            const SizedBox(height: 6),
            Text(date, style: theme.textTheme.bodySmall),
            const SizedBox(height: 8),
            Text(snippet,
                style: theme.textTheme.bodyMedium,
                maxLines: 3,
                overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }

  Widget _buildConversionHistory(
      ThemeData theme, String pair, String rate, String time) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(Icons.swap_horiz, color: theme.colorScheme.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Text(pair, style: theme.textTheme.titleMedium),
            ),
            Text(rate, style: theme.textTheme.bodyMedium),
            const SizedBox(width: 12),
            Text(time, style: theme.textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
