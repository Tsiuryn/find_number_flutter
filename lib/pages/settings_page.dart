import 'package:find_number/app/config/environment.dart';
import 'package:find_number/app/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/game_loc.dart';

class SettingsPage extends StatefulWidget {
  final Environment env;
  final Config config;

  const SettingsPage({
    Key? key,
    required this.env,
    required this.config,
  }) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late Environment _env;

  @override
  void initState() {
    super.initState();
    _env = widget.env;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings_page__appbar_title),
      ),
      body: Column(
        children: [
          _ItemWidget(
            key: UniqueKey(),
            title: l10n.settings_page__seconds,
            value: _env.seconds,
            choosingValue: _generateList(5, 200, 5),
            onSelected: (value) {
              _env = _env.copyWith(
                seconds: value,
              );
              _updateEnvironment(_env);
            },
          ),
          _ItemWidget(
            key: UniqueKey(),
            title: l10n.settings_page__horizont,
            value: _env.countViewsInHor,
            choosingValue: _generateList(1, 10, 1),
            onSelected: (value) {
              _env = _env.copyWith(
                countViewsInHor: value,
              );
              _updateEnvironment(_env);
            },
          ),
          _ItemWidget(
            key: UniqueKey(),
            title: l10n.settings_page__vertical,
            value: _env.countViewsInVer,
            choosingValue: _generateList(1, 10, 1),
            onSelected: (value) {
              _env = _env.copyWith(
                countViewsInVer: value,
              );
              _updateEnvironment(_env);
            },
          ),
          OutlinedButton(
              onPressed: () {
                setState(() {
                  _env = Environment.empty();
                });
                _updateEnvironment(_env);
              },
              child: Text(l10n.settings_page__button))
        ],
      ),
    );
  }

  List<int> _generateList(int min, int max, int step) {
    List<int> returnedList = [];
    int currentValue = min;
    while (currentValue <= max) {
      returnedList.add(currentValue);
      currentValue += step;
    }

    return returnedList;
  }

  void _updateEnvironment(Environment env) {
    widget.config.setEnvironment(env);
  }
}

class _ItemWidget extends StatefulWidget {
  final String title;
  final int value;
  final List<int> choosingValue;
  final Function(int) onSelected;

  const _ItemWidget({
    Key? key,
    required this.title,
    required this.value,
    required this.choosingValue,
    required this.onSelected,
  }) : super(key: key);

  @override
  State<_ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<_ItemWidget> {
  late List<DropdownMenuItem<int>> _popUpMenuItems;
  late int _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.value;
    _popUpMenuItems = widget.choosingValue
        .map((e) => DropdownMenuItem<int>(
            value: e,
            child: Text(e.toString(),
                style: const TextStyle(
                  fontSize: 16,
                ))))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                widget.title,
                style: style,
              )),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: DropdownButton<int>(
                  isDense: true,
                  value: _currentValue,
                  items: _popUpMenuItems,
                  menuMaxHeight: 250,
                  icon: const Icon(Icons.arrow_drop_down),
                  underline: const SizedBox(),
                  onChanged: (value) {
                    setState(() {
                      if (value != null) {
                        _currentValue = value;
                        widget.onSelected(value);
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 24.0),
          child: Divider(),
        ),
      ],
    );
  }
}
