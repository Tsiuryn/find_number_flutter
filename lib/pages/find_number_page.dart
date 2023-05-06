import 'package:find_number/app/config/environment.dart';
import 'package:find_number/app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/game_loc.dart';

import 'controller/game_controller.dart';

class FindNumberPage extends StatefulWidget {
  static const id = 'FindNumberPage';
  final Environment environment;

  const FindNumberPage({Key? key, required this.environment, }) : super(key: key);

  @override
  State<FindNumberPage> createState() => _FindNumberPageState();
}

class _FindNumberPageState extends State<FindNumberPage> {
  StatusGame statusGame = StatusGame.start;
  late GameController gameController;
  late int _secondsLeft;

  @override
  void initState() {
    super.initState();
    final env = widget.environment;
    gameController = GameController(
      seconds: env.seconds,
      layout: SetLayout(
        countViewInVert: env.countViewsInVer,
        countViewInHor: env.countViewsInHor,
      ),
      onChangedStatus: (status) {
        setState(() {
          statusGame = status;
          _secondsLeft = env.seconds;
        });
      },
      onTick: (secondsLeft) {
        setState(() {
          _secondsLeft = secondsLeft;
        });
      },
    );
    _secondsLeft = gameController.secondsLeft;
  }

  @override
  void dispose() {
    gameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(l10n.find_number_page__appbar_title),
        ),
        body: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Visibility(
              visible: statusGame == StatusGame.start,
              child: _TimerWidget(
                seconds: _secondsLeft,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: color),
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: statusGame != StatusGame.start,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        gameController.newGame();
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
                ),
                const Spacer(),
                Visibility(
                  visible: statusGame == StatusGame.start,
                  child: SizedBox(
                    height: screenSize.width,
                    width: screenSize.width,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: _ButtonsWidget(
                        data: gameController.listData,
                        currentViewData: gameController.currentViewData,
                        setLayout: gameController.layout,
                        onTapData: (data) {
                          setState(() {
                            gameController.checkData(data);
                          });
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ));
  }

  String get title {
    final l10n = AppLocalizations.of(context);

    switch (statusGame) {
      case StatusGame.start:
        return gameController.currentViewData.title;
      case StatusGame.win:
        return l10n.find_number_page__status_win;
      case StatusGame.lose:
        return l10n.find_number_page__status_lose;
    }
  }

  Color get color {
    switch (statusGame) {
      case StatusGame.start:
        return Colors.black;
      case StatusGame.win:
        return Colors.green;
      case StatusGame.lose:
        return Colors.red;
    }
  }
}

class _TimerWidget extends StatelessWidget {
  final int seconds;

  const _TimerWidget({
    Key? key,
    required this.seconds,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        _formattedSeconds,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String get _formattedSeconds {
    int m, s;

    m = seconds ~/ 60;

    s = seconds - (m * 60);

    String minuteLeft = m.toString().length < 2 ? "0$m" : m.toString();

    String secondsLeft = s.toString().length < 2 ? "0$s" : s.toString();

    String result = "$minuteLeft:$secondsLeft";

    return result;
  }
}

class _ButtonsWidget extends StatelessWidget {
  final List<GameViewData> data;
  final GameViewData currentViewData;
  final SetLayout setLayout;
  final Function(GameViewData) onTapData;

  const _ButtonsWidget({
    Key? key,
    required this.data,
    required this.currentViewData,
    required this.setLayout,
    required this.onTapData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: data
            .chunked(setLayout.countViewInHor)
            .map((e) => _RowWidget(
                  data: e,
                  currentViewData: currentViewData,
                  onTapData: onTapData,
                ))
            .toList());
  }
}

class _RowWidget extends StatelessWidget {
  final List<GameViewData> data;
  final GameViewData currentViewData;
  final Function(GameViewData) onTapData;

  const _RowWidget({
    required this.data,
    required this.currentViewData,
    required this.onTapData,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
          children: data
              .map((e) => _GameButton(
                    data: e,
                    onTap: () {
                      onTapData(e);
                    },
                    isCurrentData: e == currentViewData,
                  ))
              .toList()),
    );
  }
}

class _GameButton extends StatelessWidget {
  final GameViewData data;
  final bool isCurrentData;
  final VoidCallback onTap;

  const _GameButton({
    Key? key,
    required this.data,
    required this.onTap,
    required this.isCurrentData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const borderRadius = 8.0;

    return Expanded(
      child: Visibility(
        visible: data.isVisible,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: InkWell(
            splashColor:
                isCurrentData ? Colors.grey[200] : Colors.redAccent[200],
            borderRadius: const BorderRadius.all(Radius.circular(borderRadius)),
            onTap: isCurrentData ? onTap : () {},
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                  color: Colors.black26),
              alignment: Alignment.center,
              child: Text(
                data.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
