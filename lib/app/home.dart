import 'package:cashalog/app/transaction.dart';
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
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const TransactionPage()));
    });
  }

  void withdraw() {
    debugPrint('Withdraw');
    setState(() {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const TransactionPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
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
    ));
  }
}
