import 'package:cashalog/app/home.dart';
import 'package:flutter/material.dart';

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<StatefulWidget> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  String title = 'Cashalog';

  void updateTitle(String newTitle) {
    setState(() {
      title = newTitle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: const Center(
        child: HomePage(),
      ),
    );
  }
}
