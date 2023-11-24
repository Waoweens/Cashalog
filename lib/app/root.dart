import 'package:cashalog/app/home.dart';
import 'package:flutter/material.dart';

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<StatefulWidget> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  String title = 'Cashalog';
  int currentPageIndex = 0;

  final List<Widget> _pages = [
    const HomePage(), // Home
    const Placeholder(), // History
    const Placeholder(), // You
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: NavigationBar(
          selectedIndex: currentPageIndex,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          destinations: const <Widget>[
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.article), label: 'History'),
            NavigationDestination(icon: Icon(Icons.person), label: 'You'),
          ],
        ),
        body: IndexedStack(
          index: currentPageIndex,
          children: _pages,
        ));
  }
}
