import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyApiService {
  static const String _baseUrl = "https://open.er-api.com/v6/latest";

  /// Fetch exchange rates
  static Future<Map<String, double>> fetchRates({String base = "USD"}) async {
    final url = Uri.parse("$_baseUrl/$base");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data["result"] == "success") {
        final Map<String, dynamic> rates = data["rates"];
        return rates.map((k, v) => MapEntry(k, (v as num).toDouble()));
      } else {
        throw Exception("API error: ${data['error-type']}");
      }
    } else {
      throw Exception("Failed to fetch rates");
    }
  }
}
