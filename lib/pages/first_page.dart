import 'package:find_number/app/config/environment.dart';
import 'package:find_number/app/config/pref.dart';
import 'package:find_number/pages/find_number_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/game_loc.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  late Config _config;

  @override
  void initState() {
    super.initState();
    _config = Config();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.find_number_page__appbar_title,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                getEnv().then((value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FindNumberPage(
                        environment: value,
                      ),
                    ),
                  );
                });
              },
              child: Text(
                l10n.find_number_page__new_game,
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 28,
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                l10n.settings_page__appbar_title,
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 28,
                ),
              ),
            ),
            TextButton(
              onPressed: () {

              },
              child: Text(
                l10n.records__appbar_title,
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 28,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Environment> getEnv() {
    return _config.getEnvironment();
  }
}
