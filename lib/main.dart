import 'package:cashalog/app/root.dart';
import 'package:cashalog/db/db.dart';
import 'package:cashalog/db/history.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  isar = await Isar.open([TransactionSchema, TotalSchema], directory: dir.path);

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  static final _defaultLightColorScheme =
      ColorScheme.fromSwatch(primarySwatch: Colors.blue);

  static final _defaultDarkColorScheme = ColorScheme.fromSwatch(
      primarySwatch: Colors.blue, brightness: Brightness.dark);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      return MaterialApp(
          title: 'Cashalog',
          theme: ThemeData(
            colorScheme: lightColorScheme ?? _defaultLightColorScheme,
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            colorScheme: darkColorScheme ?? _defaultDarkColorScheme,
            useMaterial3: true,
          ),
          home: const AppRoot());
    });
  }
}
