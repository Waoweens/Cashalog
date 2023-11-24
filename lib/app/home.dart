import 'package:cashalog/components/balance_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int balance = 18651;

  void deposit() {
    debugPrint('Deposit');
    setState(() {
      balance++;
    });
  }

  void withdraw() {
    debugPrint('Withdraw');
    setState(() {
      balance--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Welcome back',
            style: TextStyle(fontSize: 36.0, fontWeight: FontWeight.w900),
          ),
          BalanceCard(
            balance: balance,
            deposit: deposit,
            withdraw: withdraw,
          )
        ],
      ),
    );
  }
}
