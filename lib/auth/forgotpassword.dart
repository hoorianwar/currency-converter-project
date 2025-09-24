import 'package:flutter/material.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => ForgotScreenState();
}

class ForgotScreenState extends State<ForgotScreen> {
  var email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive paddings
    final outerPadding = EdgeInsets.symmetric(
      horizontal: screenWidth < 600 ? 20 : screenWidth * 0.1,
      vertical: 40,
    );

    final innerPadding = EdgeInsets.symmetric(
      horizontal: screenWidth < 600 ? 20 : screenWidth * 0.08,
      vertical: 55,
    );

    final imageWidth = screenWidth < 400 ? 120 : 200;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("Forgot Password"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: outerPadding,
          child: Card(
            elevation: 30,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: innerPadding,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/images/forgot.png",
                    width: imageWidth.toDouble(),
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Forgot Password",
                    style: theme.textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: email,
                    style: theme.textTheme.bodyMedium,
                    decoration: InputDecoration(
                      labelText: "Email",
                      hintText: "Enter your email here",
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      if (email.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please enter your email')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Password reset link sent to ${email.text}"),
                          ),
                        );
                        Navigator.pushReplacementNamed(context, "/login");
                      }
                    },
                    child: const Text("Send!"),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, "/signup");
                    },
                    child: Text(
                      "Don't have an account? Signup",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

