import 'package:cashalog/utils/currency.dart';
import 'package:flutter/material.dart';

enum TransactionType { deposit, withdraw }

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key, required this.transactionType});

  final TransactionType transactionType;

  @override
  State<StatefulWidget> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();

  TransactionType type = widget.transactionType;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // Remove the currency symbol and separators before parsing.
      String numericString =
          _amountController.text.replaceAll(RegExp('[^0-9]'), '');
      final amount = int.tryParse(numericString);
      final formattedAmount = formatCurrency(amount!);

      // ignore: unnecessary_null_comparison
      if (amount != null) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Deposited $formattedAmount')));

        Navigator.of(context).pop();
      } else {
        // Handle the case where the amount couldn't be parsed.
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Invalid amount')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deposit'),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [CurrencyInputFormatter()],
                      decoration: const InputDecoration(
                          labelText: 'Amount',
                          hintText: 'Enter amount',
                          border: OutlineInputBorder()),
                      validator: (value) {
                        // Remove separators before validation.
                        String? numericOnlyValue =
                            value?.replaceAll(RegExp('[^0-9]'), '');
                        if (numericOnlyValue == null ||
                            numericOnlyValue.isEmpty) {
                          return 'Please enter an amount';
                        }
                        if (int.tryParse(numericOnlyValue) == null) {
                          return 'Please enter a valid number';
                        }
                        return null; // null means no error.
                      },
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _submit,
                            child: const Text('Deposit'),
                          ),
                        )
                      ],
                    )
                  ],
                ))
          ],
        ),
      )),
    );
  }
}
