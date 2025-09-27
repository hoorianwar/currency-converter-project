import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyNewsApi {
  static const String _apiKey = "8f9sSEXq4HI0Sd3ckbGPwgUOZjaAr9ugmk6fjRcX";

  /// ✅ Fetch currency/forex news (with fallback)
  static Future<List<dynamic>> fetchCurrencyNews({int limit = 7}) async {
    final url = Uri.parse(
      "https://api.marketaux.com/v1/news/all"
      "?filter_entities=true"
      "&topics=forex,currencies,markets,trading" // 👉 Thoda broad
      "&limit=$limit"
      "&api_token=$_apiKey",
    );

    try {
      final response = await http.get(url);
      print("🔍 API Raw Response: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data["data"] != null && data["data"].isNotEmpty) {
          final List<dynamic> articles = data["data"];

          // ✅ Thoda relaxed filter
          final filtered = articles.where((news) {
            final title = (news["title"] ?? "").toString().toLowerCase();
            final desc = (news["description"] ?? news["snippet"] ?? "")
                .toString()
                .toLowerCase();

            return title.contains("forex") ||
                title.contains("currency") ||
                title.contains("dollar") ||
                title.contains("rupee") ||
                title.contains("exchange") ||
                desc.contains("forex") ||
                desc.contains("currency") ||
                desc.contains("dollar") ||
                desc.contains("rupee") ||
                desc.contains("exchange");
          }).toList();

          // Agar filter khali ho gaya → raw hi return kar dete hain
          return filtered.isNotEmpty ? filtered : articles;
        } else {
          return [
            {
              "title": "No live currency news available",
              "description":
                  "The API did not return any currency-related articles.",
              "published_at": DateTime.now().toString()
            }
          ];
        }
      } else {
        return [
          {
            "title": "API Error",
            "description": "Status code: ${response.statusCode}",
            "published_at": DateTime.now().toString()
          }
        ];
      }
    } catch (e) {
      return [
        {
          "title": "Exception",
          "description": e.toString(),
          "published_at": DateTime.now().toString()
        }
      ];
    }
  }
}          