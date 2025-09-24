import 'package:flutter/material.dart';
import 'package:currency_conversion/user/widgets/drawer.dart';
import 'package:currency_conversion/user/widgets/bottomscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UserFeedbackScreen extends StatefulWidget {
  const UserFeedbackScreen({super.key});

  @override
  State<UserFeedbackScreen> createState() => _UserFeedbackScreenState();
}

class _UserFeedbackScreenState extends State<UserFeedbackScreen> {
  final TextEditingController _feedbackController = TextEditingController();
  List<String> _feedbacks = [];

  @override
  void initState() {
    super.initState();
    _loadFeedbacks();
  }

  Future<void> _loadFeedbacks() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('user_feedbacks');
    if (raw != null && raw.isNotEmpty) {
      try {
        setState(() {
          _feedbacks = List<String>.from(json.decode(raw));
        });
      } catch (e) {
        setState(() {
          _feedbacks = [];
        });
      }
    }
  }

  Future<void> _saveFeedbacks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_feedbacks', json.encode(_feedbacks));
  }

  void _addFeedback() async {
    final text = _feedbackController.text.trim();
    if (text.isEmpty) return;

    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('user_feedbacks');
    List<String> allFeedbacks = [];

    if (raw != null && raw.isNotEmpty) {
      try {
        allFeedbacks = List<String>.from(json.decode(raw));
      } catch (e) {
        allFeedbacks = [];
      }
    }

    allFeedbacks.add(text);

    await prefs.setString('user_feedbacks', json.encode(allFeedbacks));

    setState(() {
      _feedbacks = allFeedbacks;
    });

    _feedbackController.clear();
  }

  void _deleteFeedback(int index) {
    setState(() {
      _feedbacks.removeAt(index);
    });
    _saveFeedbacks();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("User Feedback", style: theme.textTheme.headlineMedium),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _feedbackController,
              decoration: const InputDecoration(
                labelText: "Enter your feedback",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _addFeedback,
              child: const Text("Submit Feedback"),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _feedbacks.isEmpty
                  ? Center(
                      child: Text("No feedback yet",
                          style: theme.textTheme.bodyMedium),
                    )
                  : ListView.builder(
                      itemCount: _feedbacks.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(
                              _feedbacks[index],
                              style: theme.textTheme.bodyMedium,
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _deleteFeedback(index),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      drawer: UserDrawer(),
      bottomNavigationBar: Bottomscreen(),
    );
  }
}
