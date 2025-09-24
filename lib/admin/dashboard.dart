import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:currency_conversion/admin/widgets/drawer.dart';
import 'package:currency_conversion/admin/widgets/bottomscreen.dart';



void main() {
  runApp(const AdminDashboard());
}

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _isDarkMode ? _darkTheme(context) : _lightTheme(context),
      home: Dashboard(
        isDarkMode: _isDarkMode,
        onThemeToggle: () {
          setState(() => _isDarkMode = !_isDarkMode);
        },
      ),
    );
  }

  ThemeData _lightTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      scaffoldBackgroundColor: const Color(0xFFF6FAFF),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      cardTheme: const CardThemeData(surfaceTintColor: Colors.transparent),
    );
  }

  ThemeData _darkTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: const Color(0xFF041024),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF05243A),
        elevation: 0,
      ),
      cardTheme: const CardThemeData(surfaceTintColor: Colors.transparent),
    );
  }
}

class Dashboard extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback onThemeToggle;

  const Dashboard({
    super.key,
    required this.isDarkMode,
    required this.onThemeToggle,
  });

  // BuildContext? get context => null;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      drawer: const DrawerScreen(),
      // bottomNavigationBar: const Bottomscreen(),
      appBar: AppBar(
        title: Text("Currency Dashboard", style: textTheme.titleLarge),
        actions: [
          Row(
            children: [
              Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
              Switch(value: isDarkMode, onChanged: (_) => onThemeToggle()),
            ],
          ),
        ],
      ),
      // drawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: const [
      //       DrawerHeader(
      //         decoration: BoxDecoration(color: Colors.blue),
      //         child: Text(
      //           "Menu",
      //           style: TextStyle(color: Colors.white, fontSize: 20),
      //         ),
      //       ),
      //       ListTile(leading: Icon(Icons.home), title: Text("Home")),
      //       ListTile(leading: Icon(Icons.settings), title: Text("Settings")),
      //     ],
      //   ),
      // ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Expanded(
                  child: InfoCard(
                    title: "Currencies",
                    value: "6",
                    icon: Icons.currency_exchange,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: InfoCard(
                    title: "Last Update",
                    value: "Just Now",
                    icon: Icons.update,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildChartCard(textTheme),
            const SizedBox(height: 20),
            _buildRatesTable(context),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Expanded(child: TopMoversCard()),
                SizedBox(width: 16),
                Expanded(child: RecentActivityCard()),
              ],
            ),
          ],
        ),
      ),
          bottomNavigationBar: const Bottomscreen(),
    );
  }

  Widget _buildChartCard(TextTheme textTheme) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Exchange Rate Trends", style: textTheme.titleLarge),
            const SizedBox(height: 200, child: ExchangeRateChart()),
          ],
        ),
      ),
    );
  }

  Widget _buildRatesTable(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Live Rates", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            DataTable(
              columns: const [
                DataColumn(label: Text("Currency")),
                DataColumn(label: Text("Code")),
                DataColumn(label: Text("Rate")),
              ],
              rows: _rates.map((rate) {
                return DataRow(
                  cells: [
                    DataCell(Text(rate['name']!)),
                    DataCell(Text(rate['code']!)),
                    DataCell(Text(rate['value']!)),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const InfoCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.bodyLarge),
                Text(
                  value,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Icon(icon, size: 36, color: Colors.blue),
          ],
        ),
      ),
    );
  }
}

class ExchangeRateChart extends StatelessWidget {
  const ExchangeRateChart({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true, drawVerticalLine: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true, reservedSize: 40),
          ),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.grey.shade300),
        ),
        lineBarsData: [
          LineChartBarData(
            isCurved: true,
            spots: const [
              FlSpot(0, 280),
              FlSpot(1, 282),
              FlSpot(2, 281),
              FlSpot(3, 285),
              FlSpot(4, 290),
            ],
            belowBarData: BarAreaData(
              show: true,
              color: Colors.blue.withOpacity(0.2),
            ),
            dotData: FlDotData(show: false),
            color: Colors.blue,
            barWidth: 3,
          ),
        ],
      ),
    );
  }
}

class TopMoversCard extends StatelessWidget {
  const TopMoversCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Top Movers", style: Theme.of(context).textTheme.titleLarge),
            const Divider(),
            ..._movers.map(
              (m) => ListTile(
                leading: Icon(Icons.trending_up, color: Colors.green.shade700),
                title: Text(m['code']!.toString()),
                subtitle: Text(m['name']!.toString()),
                trailing: Text(
                  m['change']!.toString(),
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecentActivityCard extends StatelessWidget {
  const RecentActivityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Recent Activity",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Divider(),
            ..._activity.map(
              (a) => ListTile(
                leading: const Icon(Icons.history),
                title: Text(a['action']!.toString()),
                subtitle: Text(
                  DateFormat(
                    'MMM dd, yyyy – kk:mm',
                  ).format(a['time'] as DateTime),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final List<Map<String, String>> _rates = [
  {"name": "US Dollar", "code": "USD", "value": "281.5"},
  {"name": "Euro", "code": "EUR", "value": "300.1"},
  {"name": "British Pound", "code": "GBP", "value": "350.7"},
];

final List<Map<String, String>> _movers = [
  {"name": "Japanese Yen", "code": "JPY", "change": "+1.2%"},
  {"name": "Canadian Dollar", "code": "CAD", "change": "+0.8%"},
  {"name": "Swiss Franc", "code": "CHF", "change": "+1.5%"},
];

final List<Map<String, dynamic>> _activity = [
  {
    "action": "Converted 100 USD to PKR",
    "time": DateTime.now().subtract(const Duration(hours: 1)),
  },
  {
    "action": "Viewed EUR trends",
    "time": DateTime.now().subtract(const Duration(hours: 3)),
  },
  {
    "action": "Updated currency list",
    "time": DateTime.now().subtract(const Duration(days: 1)),
  },
];


