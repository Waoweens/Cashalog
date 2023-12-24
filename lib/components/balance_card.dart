import 'package:cashalog/utils/currency.dart';
import 'package:flutter/material.dart';

class BalanceCard extends StatefulWidget {
  final int balance;
  final VoidCallback deposit;
  final VoidCallback withdraw;

  const BalanceCard({
    super.key,
    required this.balance,
    required this.deposit,
    required this.withdraw,
  });

  @override
  State<BalanceCard> createState() => _BalanceCardState();
}

class _BalanceCardState extends State<BalanceCard> {
  int get balance => widget.balance;
  String get formattedBalance => formatCurrency(widget.balance);

  @override
  Widget build(BuildContext context) {
    Color balanceColor = balance.isNegative
        ? Theme.of(context).colorScheme.error
        : Theme.of(context).textTheme.bodyLarge!.color!;

    return Row(
      children: [
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Your balance'),
                  Text(
                    formattedBalance,
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: balanceColor),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: TextButton(
                                  onPressed: widget.deposit,
                                  style: TextButton.styleFrom(
                                      shape: const StadiumBorder()),
                                  child: const Column(
                                    children: [
                                      Icon(Icons.download),
                                      Text('Deposit')
                                    ],
                                  ))),
                          Expanded(
                              child: TextButton(
                                  onPressed: widget.withdraw,
                                  child: const Column(
                                    children: [
                                      Icon(Icons.upload),
                                      Text('Withdraw')
                                    ],
                                  ))),
                        ],
                      ))
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
