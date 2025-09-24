import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _apiKey = "d39aunpr01ql85dgvrbgd39aunpr01ql85dgvrc0";

  /// ✅ Live News (FinancialModelingPrep API)
  static Future<List<dynamic>> fetchCurrencyNews() async {
    final url = Uri.parse(
        "https://financialmodelingprep.com/api/v3/stock_news?limit=10&apikey=$_apiKey");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data is List && data.isNotEmpty) {
        return data;
      } else {
        return [
          {
            "title": "No live news available",
            "text": "API returned empty results",
            "publishedDate": DateTime.now().toString()
          }
        ];
      }
    } else {
      return [
        {
          "title": "API Error",
          "text": "Could not fetch live news",
          "publishedDate": DateTime.now().toString()
        }
      ];
    }
  }

  /// ✅ Dummy Present News
  static Future<List<dynamic>> fetchPresentNews() async {
    return [
      {
        "title": "USD strengthens against PKR",
        "text": "Presently, USD gains momentum as import demand rises.",
        "publishedDate": "2025-09-24"
      },
      {
        "title": "Euro stable in Asian markets",
        "text": "The Euro maintains stability against major currencies today.",
        "publishedDate": "2025-09-24"
      },
      {
        "title": "GBP shows slight recovery",
        "text": "The British Pound recovers slightly amid investor optimism.",
        "publishedDate": "2025-09-24"
      },
      {
        "title": "JPY weakens against USD",
        "text": "Japanese Yen weakens as U.S. bond yields climb.",
        "publishedDate": "2025-09-24"
      },
      {
        "title": "Oil prices push CAD upward",
        "text": "Canadian Dollar strengthens as crude oil demand rises.",
        "publishedDate": "2025-09-24"
      },
    ];
  }

  /// ✅ Dummy History News
  static Future<List<dynamic>> fetchHistoryNews() async {
    return [
      {
        "title": "PKR faced sharp devaluation in 2020",
        "text":
            "Amid global uncertainty, PKR witnessed a record decline against USD.",
        "publishedDate": "2020-03-10"
      },
      {
        "title": "GBP surged during Brexit talks in 2019",
        "text": "The British Pound showed unusual strength during Brexit debates.",
        "publishedDate": "2019-07-18"
      },
      {
        "title": "USD dominance during 2008 crisis",
        "text":
            "The financial crisis boosted USD demand as a safe-haven currency.",
        "publishedDate": "2008-11-05"
      },
      {
        "title": "Euro debt crisis hit EUR in 2011",
        "text":
            "Euro weakened drastically during the European sovereign debt crisis.",
        "publishedDate": "2011-06-22"
      },
      {
        "title": "JPY strong in 2016",
        "text":
            "Japanese Yen surged amid global demand for safer investment assets.",
        "publishedDate": "2016-02-14"
      },
    ];
  }
}
