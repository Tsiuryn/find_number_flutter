import 'package:find_number/pages/first_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/game_loc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: const [
        Locale('en'), // English
        Locale('ru'), // Spanish
      ],
      locale: const Locale('ru'),
      home: const FirstPage(),
    );
  }
}
