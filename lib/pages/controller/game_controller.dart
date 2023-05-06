import 'dart:async';

import 'package:collection/collection.dart';

enum StatusGame { start, win, lose }

class GameController {
  final int seconds;
  final SetLayout layout;
  final Function(StatusGame) onChangedStatus;
  final Function(int currentTime)? onTick;

  GameController({
    required this.seconds,
    required this.onChangedStatus,
    this.layout = const SetLayout(),
    this.onTick,
  }) {
    _setUpGame();
  }

  late int _currentTime;
  Timer? _timer;
  final List<int> _data = List.generate(300, (index) => index);
  late GameViewData _controllerCurrentViewData;
  List<GameViewData> _controllerListData = [];

  int get secondsLeft => _currentTime;
  List<GameViewData> get listData => _controllerListData;
  GameViewData get currentViewData => _controllerCurrentViewData;

  void _setUpGame() {
    _currentTime = seconds;
    final countNumbers = layout.countViewInVert * layout.countViewInHor;
    final genList = _data..shuffle();
    _controllerListData = genList
        .sublist(0, countNumbers)
        .map((e) => GameViewData(title: '$e'))
        .toList();
    final shuffleList = [..._controllerListData]..shuffle();
    _controllerCurrentViewData = shuffleList.first;
    _startTimer();
  }

  void newGame() {
    _setUpGame();
    onChangedStatus(StatusGame.start);
  }

  void checkData(GameViewData data) {
    if(_controllerCurrentViewData != data) return;

    final index = _controllerListData.indexOf(data);
    _controllerListData[index] = data.copyWith(isVisible: false);
    final shuffleList = [..._controllerListData]..shuffle();
    final currentData =
        shuffleList.firstWhereOrNull((element) => element.isVisible);
    if (currentData == null) {
      onChangedStatus(StatusGame.win);
      _timer?.cancel();
    } else {
      _controllerCurrentViewData = currentData;
    }
  }

  void _startTimer () {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        _currentTime--;
        onTick?.call(_currentTime);
        if(_currentTime == 0){
          onChangedStatus(StatusGame.lose);
          timer.cancel();
        }
      },
    );
  }

  void dispose(){
    _timer?.cancel();
  }
}

class GameViewData {
  final String title;
  final bool isVisible;

  const GameViewData({
    required this.title,
    this.isVisible = true,
  });

  GameViewData copyWith({
    String? title,
    bool? isVisible,
  }) {
    return GameViewData(
      title: title ?? this.title,
      isVisible: isVisible ?? this.isVisible,
    );
  }
}

class SetLayout {
  final int countViewInHor;
  final int countViewInVert;

  const SetLayout({
    this.countViewInHor = 2,
    this.countViewInVert = 2,
  });
}
