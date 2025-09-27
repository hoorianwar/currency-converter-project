import 'dart:convert';
import 'package:http/http.dart' as http;

class OtpService {
  // ⚠️ Apna Firebase Functions ka base URL yahan dalna
  // Example: https://us-central1-your-project-id.cloudfunctions.net
  static const String baseUrl = "https://us-central1-YOUR_PROJECT_ID.cloudfunctions.net";

  /// Send OTP to email
  static Future<bool> sendOtp(String email) async {
    try {
      final Uri url = Uri.parse('$baseUrl/sendEmailOtp');
      final res = await http.post(
        url,
        body: jsonEncode({'email': email}),
        headers: {'Content-Type': 'application/json'},
      );

      if (res.statusCode == 200) {
        return true;
      } else {
        print("Send OTP failed: ${res.body}");
        return false;
      }
    } catch (e) {
      print("Send OTP Exception: $e");
      return false;
    }
  }

  /// Verify OTP
  static Future<bool> verifyOtp(String email, String otp) async {
    try {
      final Uri url = Uri.parse('$baseUrl/verifyEmailOtp');
      final res = await http.post(
        url,
        body: jsonEncode({'email': email, 'otp': otp}),
        headers: {'Content-Type': 'application/json'},
      );

      if (res.statusCode == 200) {
        return true;
      } else {
        print("Verify OTP failed: ${res.body}");
        return false;
      }
    } catch (e) {
      print("Verify OTP Exception: $e");
      return false;
    }
  }
}
