import 'package:flutter/material.dart';

import 'mortgage.dart';
import 'mortgage_edit_screen.dart';

void main() => runApp(const MortgageApp());

class MortgageApp extends StatelessWidget {
  const MortgageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mortgage Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MortgageSummaryScreen(),
    );
  }
}

class MortgageSummaryScreen extends StatefulWidget {
  const MortgageSummaryScreen({super.key});

  @override
  State<MortgageSummaryScreen> createState() => _MortgageSummaryScreenState();
}

class _MortgageSummaryScreenState extends State<MortgageSummaryScreen> {
  Mortgage _mortgage = Mortgage();

  Future<void> _editMortgage() async {
    final updatedMortgage = await Navigator.push<Mortgage>(
      context,
      MaterialPageRoute(
        builder: (context) => EditMortgageScreen(
          mortgage: Mortgage(
            amount: _mortgage.amount,
            years: _mortgage.years,
            rate: _mortgage.rate,
          ),
        ),
      ),
    );

    if (updatedMortgage != null) {
      setState(() {
        _mortgage = updatedMortgage;
      });
    }
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mortgage Summary')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mortgage Summary',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSummaryRow('Home Price', _mortgage.formattedAmount()),
                    _buildSummaryRow('Interest Rate', '${(_mortgage.rate * 100).toStringAsFixed(2)}%'),
                    _buildSummaryRow('Loan Term', '${_mortgage.years} years'),
                    const Divider(height: 32),
                    _buildSummaryRow('Monthly Payment', _mortgage.formattedMonthlyPayment()),
                    _buildSummaryRow('Total Payment', _mortgage.formattedTotalPayment()),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _editMortgage,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                child: Text('Edit Mortgage Data', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
