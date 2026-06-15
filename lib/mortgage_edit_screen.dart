import 'package:flutter/material.dart';
import 'package:mortgage_calculator_app/mortgage.dart';

class EditMortgageScreen extends StatefulWidget {
  final Mortgage mortgage;

  const EditMortgageScreen({super.key, required this.mortgage});

  @override
  State<EditMortgageScreen> createState() => _EditMortgageScreenState();
}

class _EditMortgageScreenState extends State<EditMortgageScreen> {
  late final TextEditingController _amountController;
  late final TextEditingController _yearsController;
  late double _selectedRate;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(
      text: widget.mortgage.amount.toStringAsFixed(0),
    );
    _yearsController = TextEditingController(
      text: widget.mortgage.years.toString(),
    );
    _selectedRate = widget.mortgage.rate * 100;
  }

  @override
  void dispose() {
    _amountController.dispose();
    _yearsController.dispose();
    super.dispose();
  }

  void _saveAndReturn() {
    widget.mortgage.amount =
        double.tryParse(_amountController.text) ?? widget.mortgage.amount;
    widget.mortgage.years =
        int.tryParse(_yearsController.text) ?? widget.mortgage.years;
    widget.mortgage.rate = _selectedRate / 100;

    Navigator.pop(context, widget.mortgage);
  }

  @override
  Widget build(BuildContext context) {
    final rates = List.generate(53, (index) => 2.0 + index * 0.25);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Mortgage Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Home Price',
                prefixText: '\$',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _yearsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Loan Term (Years)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Interest Rate',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: rates.length,
                itemBuilder: (context, index) {
                  final rate = rates[index];
                  final selected = rate == _selectedRate;

                  return ListTile(
                    title: Text('${rate.toStringAsFixed(2)}%'),
                    trailing: selected ? const Icon(Icons.check, color: Colors.blue) : null,
                    selected: selected,
                    selectedTileColor: Colors.blue.shade50,
                    onTap: () {
                      setState(() {
                        _selectedRate = rate;
                      });
                    },
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _saveAndReturn,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                child: Text('Save Mortgage Data', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
