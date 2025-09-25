import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyNewsApi {
  static const String _apiKey = "8f9sSEXq4HI0Sd3ckbGPwgUOZjaAr9ugmk6fjRcX";

  /// ✅ Fetch live currency/forex news
  static Future<List<dynamic>> fetchCurrencyNews({required int limit}) async {
    final url = Uri.parse(
        "https://api.marketaux.com/v1/news/all?filter_entities=true&countries=us,gb,pk&topics=forex,currencies&api_token=$_apiKey");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data["data"] != null && data["data"].isNotEmpty) {
          return data["data"]; // List of news
        } else {
          return [
            {
              "title": "No live news available",
              "description": "API returned empty results",
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


