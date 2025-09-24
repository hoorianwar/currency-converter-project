import 'package:currency_conversion/admin/widgets/drawer.dart';
import 'package:currency_conversion/admin/widgets/bottomscreen.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UserFeedback extends StatefulWidget {
  const UserFeedback({super.key});

  @override
  State<UserFeedback> createState() => _UserFeedbackState();
}

class _UserFeedbackState extends State<UserFeedback> {
  List<String> _allFeedbacks = [];

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
          _allFeedbacks = List<String>.from(json.decode(raw));
        });
      } catch (e) {
        debugPrint("Error decoding feedbacks: $e");
        setState(() {
          _allFeedbacks = [];
        });
      }
    }
  }

  Future<void> _saveFeedbacks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_feedbacks', json.encode(_allFeedbacks));
  }

  void _deleteFeedback(int index) {
    setState(() {
      _allFeedbacks.removeAt(index);
    });
    _saveFeedbacks();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("All User Feedback", style: theme.textTheme.headlineMedium),
        centerTitle: true,
      ),
      body: _allFeedbacks.isEmpty
          ? Center(
              child: Text(
                "No feedback submitted yet",
                style: theme.textTheme.bodyMedium,
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _allFeedbacks.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(
                      _allFeedbacks[index],
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
      drawer: DrawerScreen(),
      bottomNavigationBar: const Bottomscreen(),
    );
  }
}

