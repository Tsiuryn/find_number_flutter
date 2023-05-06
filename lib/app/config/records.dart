import 'package:json_annotation/json_annotation.dart';

part 'records.g.dart';

@JsonSerializable()
class Records {
  final List<AppRecord> records;

  const Records({
    required this.records,
  });

  Records.empty() : records = [];

  factory Records.fromJson(Map<String, dynamic> json) =>
      _$RecordsFromJson(json);

  Map<String, dynamic> toJson() => _$RecordsToJson(this);
}

@JsonSerializable()
class AppRecord {
  final int countViewsInVer;
  final int countViewsInHor;
  final int seconds;
  final String date;

  const AppRecord({
    required this.countViewsInVer,
    required this.countViewsInHor,
    required this.seconds,
    required this.date,
  });

  factory AppRecord.fromJson(Map<String, dynamic> json) =>
      _$AppRecordFromJson(json);

  Map<String, dynamic> toJson() => _$AppRecordToJson(this);
}
