import 'package:json_annotation/json_annotation.dart';

part 'environment.g.dart';

@JsonSerializable()
class Environment {
  final int countViewsInVer;
  final int countViewsInHor;
  final int seconds;

  const Environment({
    required this.countViewsInVer,
    required this.countViewsInHor,
    required this.seconds,
  });

  Environment.empty()
      : countViewsInHor = 3,
        countViewsInVer = 3,
        seconds = 30;

  factory Environment.fromJson(Map<String, dynamic> json) =>
      _$EnvironmentFromJson(json);

  Map<String, dynamic> toJson() => _$EnvironmentToJson(this);

  Environment copyWith({
    int? countViewsInVer,
    int? countViewsInHor,
    int? seconds,
  }) {
    return Environment(
      countViewsInVer: countViewsInVer ?? this.countViewsInVer,
      countViewsInHor: countViewsInHor ?? this.countViewsInHor,
      seconds: seconds ?? this.seconds,
    );
  }
}
