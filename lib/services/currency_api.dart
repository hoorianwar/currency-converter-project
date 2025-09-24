import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyApi {
  static const String apiKey = "f63a0ba68c219aa8198e7c35";
  static const String baseUrl = "https://v6.exchangerate-api.com/v6";

  Future<Map<String, double>> getRates(String baseCurrency) async {
    final url = Uri.parse("$baseUrl/$apiKey/latest/$baseCurrency");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data != null &&
          data is Map<String, dynamic> &&
          data.containsKey("conversion_rates")) {
        final rates = Map<String, dynamic>.from(data["conversion_rates"]);
        return rates.map((key, value) =>
            MapEntry(key, (value as num).toDouble()));
      } else {
        throw Exception("Invalid API response format");
      }
    } else {
      throw Exception("Error loading rates: ${response.statusCode}");
    }
  }
}
