import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // 👇 apni Finnhub wali API key yahan daalna
  static const String _apiKey = "d39aunpr01ql85dgvrbgd39aunpr01ql85dgvrc0";

  // Currency rates ka base API
  static const String _baseRatesUrl = "https://api.exchangerate.host";

  // Finnhub news ka base API
  static const String _baseNewsUrl = "https://finnhub.io/api/v1";

  /// Get latest currency rates
  static Future<Map<String, dynamic>> getRates(String base) async {
    final url = Uri.parse("$_baseRatesUrl/latest?base=$base");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load rates");
    }
  }

  /// Get historical currency data
  static Future<Map<String, dynamic>> getHistory(
    String base,
    String date,
  ) async {
    final url = Uri.parse("$_baseRatesUrl/$date?base=$base");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load history");
    }
  }

  /// Get forex news (Finnhub)
  static Future<Map<String, dynamic>> getNews() async {
    final url = Uri.parse(
      "$_baseNewsUrl/news?category=forex&token=$_apiKey",
    ); // 👈 forex news
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      return {"articles": body};
    } else {
      throw Exception("Failed to load news: ${response.statusCode}");
    }
  }
}
