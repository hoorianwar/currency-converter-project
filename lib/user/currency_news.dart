import 'package:flutter/material.dart';
import '../services/currency_news_api.dart';
import 'package:currency_conversion/admin/widgets/drawer.dart';
import 'package:currency_conversion/admin/widgets/bottomscreen.dart';

class MarketTrendScreen extends StatefulWidget {
  const MarketTrendScreen({super.key});

  @override
  State<MarketTrendScreen> createState() => _MarketTrendScreenState();
}

class _MarketTrendScreenState extends State<MarketTrendScreen> {
  late Future<List<dynamic>> presentNews;
  late Future<List<dynamic>> historyNews;
  late Future<List<dynamic>> liveNews;

  @override
  void initState() {
    super.initState();
    // ✅ Tino section ek hi API ko call karenge abhi
    presentNews = CurrencyNewsApi.fetchCurrencyNews();
    historyNews = CurrencyNewsApi.fetchCurrencyNews();
    liveNews = CurrencyNewsApi.fetchCurrencyNews();
  }

  Widget _buildNewsSection(String title, Future<List<dynamic>> futureNews) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 10),
        FutureBuilder<List<dynamic>>(
          future: futureNews,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Text("⚠️ Error loading news");
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text("No news available");
            }

            final newsList = snapshot.data!;
            return Column(
              children: newsList.map((news) {
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.article,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    title: Text(
                      news["title"] ?? "No title",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(news["description"] ?? ""),
                    trailing: Text(
                      news["published_at"]?.toString().split("T").first ?? "",
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerScreen(),
      appBar: AppBar(
        title: const Text("Currency News"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildNewsSection("📌 Present Currency News", presentNews),
            _buildNewsSection("📖 History Currency News", historyNews),
            _buildNewsSection("📰 Latest Market News", liveNews),
          ],
        ),
      ),
      bottomNavigationBar: const Bottomscreen(),
    );
  }
}
