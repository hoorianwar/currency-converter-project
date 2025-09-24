import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:currency_conversion/user/widgets/drawer.dart';
import 'package:currency_conversion/user/widgets/bottomscreen.dart';
import 'package:currency_conversion/services/currency_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrencyConversionScreen extends StatefulWidget {
  const CurrencyConversionScreen({super.key});

  @override
  State<CurrencyConversionScreen> createState() =>
      _CurrencyConversionScreenState();
}

class _CurrencyConversionScreenState extends State<CurrencyConversionScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  String fromCurrency = 'USD';
  String toCurrency = 'INR';
  double? result;

  Map<String, double> _rates = {};
  List<String> _currencies = [];
  List<String> _filteredCurrencies = [];

  final CurrencyApi _currencyApi = CurrencyApi();

  @override
  void initState() {
    super.initState();
    fetchRates();
    _searchController.addListener(_filterCurrencies);
  }

  /// Fetch API rates + merge admin currencies
  Future<void> fetchRates() async {
    try {
      final apiRates = await _currencyApi.getRates(fromCurrency);
      final mergedRates = Map<String, double>.from(apiRates);

      // load admin currencies from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString('admin_currencies');
      if (raw != null && raw.isNotEmpty) {
        try {
          final Map<String, dynamic> parsed = json.decode(raw);
          parsed.forEach((k, v) {
            mergedRates[k.toUpperCase()] = (v as num).toDouble();
          });
        } catch (_) {}
      }

      setState(() {
        _rates = mergedRates;
        _currencies = mergedRates.keys.toList()..sort();
        _filteredCurrencies = _currencies;
      });
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to load rates: $e")),
        );
      });
    }
  }

  void _filterCurrencies() {
    final query = _searchController.text.toUpperCase();
    setState(() {
      _filteredCurrencies = _currencies
          .where((c) => c.toUpperCase().contains(query))
          .toList();
    });
  }

  void convert() {
    double amount = double.tryParse(_amountController.text) ?? 0.0;

    if (_rates.isEmpty || !_rates.containsKey(toCurrency)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Conversion rate not available")),
      );
      return;
    }

    setState(() {
      result = amount * (_rates[toCurrency] ?? 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Currency Converter',
          style: theme.textTheme.headlineMedium,
        ),
        centerTitle: true,
      ),
      drawer: const UserDrawer(),
      bottomNavigationBar: const Bottomscreen(),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Instant Currency Conversion",
                  style: theme.textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                // Amount input
                _buildAmountField(theme),
                const SizedBox(height: 20),

                // Search bar
                TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    labelText: "Search Currency",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),

                // Dropdowns
                Row(
                  children: [
                    Expanded(
                      child: _buildCurrencyDropdown(
                        theme,
                        fromCurrency,
                        (val) {
                          setState(() {
                            fromCurrency = val!;
                            fetchRates(); // refresh rates
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child:
                          Icon(Icons.swap_horiz, color: theme.iconTheme.color),
                    ),
                    Expanded(
                      child: _buildCurrencyDropdown(
                        theme,
                        toCurrency,
                        (val) => setState(() => toCurrency = val!),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                ElevatedButton(
                  onPressed: convert,
                  child: const Text("Convert"),
                ),
                const SizedBox(height: 30),

                if (result != null)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        "$fromCurrency → $toCurrency = ${result!.toStringAsFixed(2)}",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineMedium,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAmountField(ThemeData theme) {
    return TextField(
      controller: _amountController,
      keyboardType: TextInputType.number,
      style: theme.textTheme.bodyMedium,
      decoration: InputDecoration(
        filled: true,
        labelText: 'Enter Amount',
        prefixIcon: Icon(Icons.attach_money, color: theme.iconTheme.color),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildCurrencyDropdown(
    ThemeData theme,
    String selectedCurrency,
    ValueChanged<String?> onChanged,
  ) {
    if (_filteredCurrencies.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return DropdownButtonFormField<String>(
      initialValue: _filteredCurrencies.contains(selectedCurrency)
          ? selectedCurrency
          : null,
      decoration: const InputDecoration(
        labelText: 'Currency',
        border: OutlineInputBorder(),
      ),
      style: theme.textTheme.bodyMedium,
      items: _filteredCurrencies.map((currency) {
        return DropdownMenuItem(
          value: currency,
          child: Text(currency),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
