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
    presentNews = ApiService.fetchPresentNews();
    historyNews = ApiService.fetchHistoryNews();
    liveNews = ApiService.fetchCurrencyNews();
  }

  Widget _buildNewsSection(String title, Future<List<dynamic>> futureNews) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 10),
        FutureBuilder<List<dynamic>>(
          future: futureNews,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Text("⚠️ Error loading news");
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text("No news available");
            }

            return Column(
              children: snapshot.data!.map((item) {
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.article, color: Colors.blue),
                    title: Text(
                      item["title"] ?? "",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(item["text"] ?? ""),
                    trailing: Text(
                      item["publishedDate"]?.toString().split("T").first ?? "",
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
        backgroundColor: Colors.blue,
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





// import 'package:flutter/material.dart';
// import 'package:currency_conversion/user/widgets/drawer.dart';
// import 'package:currency_conversion/user/widgets/bottomscreen.dart';

// class MarketTrendScreen extends StatelessWidget {
//   const MarketTrendScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     //  final themeProvider = Provider.of<ThemeProvider>(context);
//      return Scaffold(
//       // backgroundColor: const Color(0xFF121212), // Jet black
//       appBar: AppBar(
//         // backgroundColor: const Color(0xFFFCD535), // Binance Yellow
//         title: const Text(
//           'Currency Converter',
        
//         ),
//         centerTitle: true,
//       ),
//       drawer: UserDrawer(),
//       body: Center(
      
//       ),
//       bottomNavigationBar: Bottomscreen(),
//   );
// }
// }