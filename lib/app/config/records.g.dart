// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'records.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Records _$RecordsFromJson(Map<String, dynamic> json) => Records(
      records: (json['records'] as List<dynamic>)
          .map((e) => AppRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RecordsToJson(Records instance) => <String, dynamic>{
      'records': instance.records,
    };

AppRecord _$AppRecordFromJson(Map<String, dynamic> json) => AppRecord(
      countViewsInVer: json['countViewsInVer'] as int,
      countViewsInHor: json['countViewsInHor'] as int,
      seconds: json['seconds'] as int,
      date: json['date'] as String,
    );

Map<String, dynamic> _$AppRecordToJson(AppRecord instance) => <String, dynamic>{
      'countViewsInVer': instance.countViewsInVer,
      'countViewsInHor': instance.countViewsInHor,
      'seconds': instance.seconds,
      'date': instance.date,
    };
