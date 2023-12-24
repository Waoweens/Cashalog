import 'package:cashalog/db/history.dart';
import 'package:cashalog/utils/currency.dart';
import 'package:flutter/material.dart';
import 'package:cashalog/db/db.dart';
import 'package:isar/isar.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key, required this.type});

  final TransactionType type;

  @override
  State<StatefulWidget> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final TransactionType type = widget.type;
    final String title =
        type == TransactionType.deposit ? 'Deposit' : 'Withdraw';

    if (_formKey.currentState!.validate()) {
      // Remove the currency symbol and separators before parsing.
      String numericString =
          _amountController.text.replaceAll(RegExp('[^0-9]'), '');

      String description = _descriptionController.text;

      final amount = int.tryParse(numericString);
      final formattedAmount = formatCurrency(amount!);

      // ignore: unnecessary_null_comparison
      if (amount != null) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${title}ed $formattedAmount')));

        final Transaction newTransaction;
        if (type == TransactionType.deposit) {
          newTransaction = Transaction()
            ..date = DateTime.now()
            ..amount = amount
            ..type = TransactionType.deposit
            ..description = description;
        } else {
          newTransaction = Transaction()
            ..date = DateTime.now()
            ..amount = amount
            ..type = TransactionType.withdraw
            ..description = description;
        }

        await isar.writeTxn(() async {
          await isar.transactions.put(newTransaction);
        });

        // calculate total
        // after each transcation, get all transactions and calculate the total
        // this is inneficient, but it prevents weird race conditions

        // get all transactions
        final allTransactions = await isar.transactions.where().findAll();

        // calculate total
        int newTotal = 0;
        for (var transaction in allTransactions) {
          if (transaction.type == TransactionType.deposit) {
            newTotal += transaction.amount!;
          } else {
            newTotal -= transaction.amount!;
          }
        }

        // save total
        final total = Total()
          ..date = DateTime.now()
          ..total = newTotal;

        await isar.writeTxn(() async {
          await isar.totals.put(total);
        });

        if (!context.mounted) return;
        Navigator.of(context).pop(newTotal);
      } else {
        // Handle the case where the amount couldn't be parsed.
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Invalid amount')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final TransactionType type = widget.type;
    final String title =
        type == TransactionType.deposit ? 'Deposit' : 'Withdraw';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
                    TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                          labelText: 'Description',
                          hintText: 'Enter description',
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description';
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
                            child: Text(title),
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
