import 'dart:convert';
import 'package:currency_conversion/admin/widgets/drawer.dart';
import 'package:currency_conversion/admin/widgets/bottomscreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:currency_conversion/services/currency_api_service.dart';

/// Service to load admin currencies (local storage + API)
class AdminCurrencyService {
  static const String _prefsKey = 'admin_currencies';
  final ValueNotifier<Map<String, double>> notifier = ValueNotifier({});

  AdminCurrencyService() {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_prefsKey);

    if (raw != null && raw.isNotEmpty) {
      try {
        final Map<String, dynamic> parsed = json.decode(raw);
        final Map<String, double> casted =
            parsed.map((k, v) => MapEntry(k, (v as num).toDouble()));
        notifier.value = Map<String, double>.from(casted);
      } catch (e) {
        debugPrint("Error decoding currencies: $e");
        notifier.value = {};
      }
    } else {
      notifier.value = {};
    }
  }

  Map<String, double> get current => notifier.value;
}

class CurrencyList extends StatefulWidget {
  const CurrencyList({super.key});

  @override
  State<CurrencyList> createState() => _CurrencyListState();
}

class _CurrencyListState extends State<CurrencyList> {
  late final AdminCurrencyService _service;
  final _searchController = TextEditingController();
  String _searchQuery = '';
  Map<String, double> _liveRates = {};
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _service = AdminCurrencyService();
    _loadData();

    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.trim().toUpperCase();
      });
    });
  }

  Future<void> _loadData() async {
    try {
      final rates = await CurrencyApiService.fetchRates(base: "USD");

      setState(() {
        _liveRates = rates;
        _loading = false;
      });
    } catch (e) {
      debugPrint("Error fetching live rates: $e");
      setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _service.notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Admin — Currencies', style: theme.textTheme.headlineSmall),
        centerTitle: true,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Search
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Search currency code',
                      prefixIcon:
                          Icon(Icons.search, color: theme.iconTheme.color),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // List
                  Expanded(
                    child: ValueListenableBuilder<Map<String, double>>(
                      valueListenable: _service.notifier,
                      builder: (context, localMap, _) {
                        // merge live rates + admin custom rates
                        final combined = Map<String, double>.from(_liveRates)
                          ..addAll(localMap);

                        final entries = combined.entries
                            .where((e) => _searchQuery.isEmpty ||
                                e.key.contains(_searchQuery))
                            .toList()
                          ..sort((a, b) => a.key.compareTo(b.key));

                        if (entries.isEmpty) {
                          return Center(
                            child: Text('No currencies found',
                                style: theme.textTheme.bodyLarge),
                          );
                        }

                        return ListView.separated(
                          itemCount: entries.length,
                          separatorBuilder: (_, __) => const Divider(),
                          itemBuilder: (context, index) {
                            final code = entries[index].key;
                            final rate = entries[index].value;
                            return ListTile(
                              title: Text(code,
                                  style: theme.textTheme.titleMedium),
                              subtitle: Text('Rate: $rate',
                                  style: theme.textTheme.bodySmall),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
      drawer: DrawerScreen(),
      bottomNavigationBar: const Bottomscreen(),
    );
  }
}
