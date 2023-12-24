import 'package:cashalog/app/history.dart';
import 'package:cashalog/app/home.dart';
import 'package:flutter/material.dart';

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<StatefulWidget> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  int currentPageIndex = 0;

  final List<PageData> _pages = [
    const PageData(page: HomePage(), title: 'Cashalog'),
    const PageData(page: HistoryPage(), title: 'History'),
    const PageData(page: Placeholder(), title: 'You'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(_pages[currentPageIndex].title)),
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
          children: _pages.map((pageData) => pageData.page).toList(),
        ));
  }
}

class PageData {
  final String title;
  final Widget page;

  const PageData({required this.title, required this.page});
}
