import 'package:currency_conversion/firebase.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/otp_service.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  final _formKey = GlobalKey<FormState>();
  final DefaultFirebaseOptions _auth = DefaultFirebaseOptions.instance;

  final TextEditingController _emailController = TextEditingController();

  Future<void> _submitForgotPassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        final email = _emailController.text.trim();

        // 1️⃣ Send OTP
        bool sent = await OtpService.sendOtp(email);
        if (!sent) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to send OTP')),
          );
          return;
        }

        // 2️⃣ OTP input dialog
        String? otp = await showDialog<String>(
          context: context,
          builder: (ctx) {
            final otpController = TextEditingController();
            return AlertDialog(
              title: const Text('Verify Email'),
              content: TextField(
                controller: otpController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Enter OTP'),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(ctx, otpController.text.trim()),
                  child: const Text('Verify'),
                ),
              ],
            );
          },
        );

        if (otp == null || otp.isEmpty) return;

        // 3️⃣ Verify OTP
        bool verified = await OtpService.verifyOtp(email, otp);

        if (verified) {
          await _auth.sendPasswordResetEmail(email: email);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password reset email sent!')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid OTP')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: _submitForgotPassword,
          child: const Text("Reset Password"),
        ),
      ),
    );
  }
}
