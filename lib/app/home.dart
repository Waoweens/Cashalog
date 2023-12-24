import 'package:cashalog/app/transaction.dart';
import 'package:cashalog/components/balance_card.dart';
import 'package:cashalog/db/db.dart';
import 'package:cashalog/db/history.dart';
import 'package:cashalog/utils/currency.dart';
import 'package:cashalog/utils/platform.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int balance = 0;

  @override
  void initState() {
    super.initState();
    updateBalance();
  }

  Future<void> updateBalance() async {
    // get the last total
    final total =
        await isar.totals.where(sort: Sort.desc).anyId().limit(1).findAll();
    setState(() {
      if (total.isNotEmpty) {
        balance = total.last.total!;
      } else {
        balance = 0;
      }
    });
  }

  Future<void> deposit() async {
    debugPrint('Deposit');
    // Wait for the Navigator to pop
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TransactionPage(
          type: TransactionType.deposit,
        ),
      ),
    );

    // Perform actions after the Navigator pops
    if (result != null) {
      updateBalance();
    }
  }

  Future<void> withdraw() async {
    debugPrint('Withdraw');
    // Wait for the Navigator to pop
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TransactionPage(
          type: TransactionType.withdraw,
        ),
      ),
    );

    // Perform actions after the Navigator pops
    if (result != null) {
      updateBalance();
    }
  }

  Future<void> _refresh() {
    return Future<void>.delayed(const Duration(seconds: 1), () {
      setState(() {
        updateBalance();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: ListView(
                children: <Widget>[
                  nonTouchRefreshButton(_refresh),
                  const Text(
                    'Welcome back',
                    style:
                        TextStyle(fontSize: 36.0, fontWeight: FontWeight.w900),
                  ),
                  BalanceCard(
                    balance: balance,
                    deposit: deposit,
                    withdraw: withdraw,
                  )
                ],
              ),
            )));
  }
}
