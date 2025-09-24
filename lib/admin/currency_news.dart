import 'package:currency_conversion/admin/widgets/bottomscreen.dart';
import 'package:currency_conversion/admin/widgets/drawer.dart';
import 'package:flutter/material.dart';
import '../services/currency_news_api.dart';

class CurrencyNews extends StatefulWidget {
  const CurrencyNews({super.key});

  @override
  State<CurrencyNews> createState() => _CurrencyNewsState();
}

class _CurrencyNewsState extends State<CurrencyNews> {
  String selectedTab = "present"; // present, history, news
  Map<String, dynamic>? data;
  String? error;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      if (selectedTab == "present") {
  data = await ApiService.getRates("USD");
} else if (selectedTab == "history") {
  data = await ApiService.getHistory("USD", "2025-09-01");
} else if (selectedTab == "news") {
  data = await ApiService.getNews();
}

    } catch (e) {
      error = e.toString();
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerScreen(),
      appBar: AppBar(
        title: const Text("Currency News"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: fetchData,
          ),
        ],
      ),
      body: Column(
        children: [
          // --- Tabs ---
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ChoiceChip(
                label: const Text("Present"),
                selected: selectedTab == "present",
                onSelected: (_) {
                  setState(() => selectedTab = "present");
                  fetchData();
                },
              ),
              const SizedBox(width: 10),
              ChoiceChip(
                label: const Text("History"),
                selected: selectedTab == "history",
                onSelected: (_) {
                  setState(() => selectedTab = "history");
                  fetchData();
                },
              ),
              const SizedBox(width: 10),
              ChoiceChip(
                label: const Text("News"),
                selected: selectedTab == "news",
                onSelected: (_) {
                  setState(() => selectedTab = "news");
                  fetchData();
                },
              ),
            ],
          ),

          // --- Content ---
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : error != null
                    ? Center(
                        child: Text(
                          "⚠️ $error",
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : _buildContent(),
          ),
        ],
      ),
      bottomNavigationBar: const Bottomscreen(),
    );
  }

  Widget _buildContent() {
    if (data == null) {
      return const Center(child: Text("No data available"));
    }

    if (selectedTab == "present" || selectedTab == "history") {
      // ✅ Present & History ko bhi News style me show karte hain
      final rates = Map<String, dynamic>.from(data!["rates"] ?? {});
      return ListView.builder(
        itemCount: rates.length,
        itemBuilder: (context, index) {
          final entry = rates.entries.elementAt(index);
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text(
                  entry.key.substring(0, 2), // e.g. "US"
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              title: Text(
                entry.key,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Currency Rate"),
              trailing: Text(
                entry.value.toStringAsFixed(2),
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      );
    } else if (selectedTab == "news") {
      final articles = List<Map<String, dynamic>>.from(data!["articles"] ?? []);
      return ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final item = articles[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Text(item["headline"] ?? "No Title"),
              subtitle: Text(item["source"] ?? ""),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            ),
          );
        },
      );
    }

    return const SizedBox.shrink();
  }
}
