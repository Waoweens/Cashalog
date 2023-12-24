import 'package:cashalog/utils/platform.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<StatefulWidget> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  // @override
  // void initState() {
  //   super.initState();
  // }

  Future<void> _refresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print('HistoryPage: ${ModalRoute.of(context)?.isCurrent}');
    return SafeArea(
      child: RefreshIndicator(
          onRefresh: _refresh,
          child: ListView(children: <Widget>[nonTouchRefreshButton(_refresh)])),
    );
  }
}
