// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'environment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Environment _$EnvironmentFromJson(Map<String, dynamic> json) => Environment(
      countViewsInVer: json['countViewsInVer'] as int,
      countViewsInHor: json['countViewsInHor'] as int,
      seconds: json['seconds'] as int,
    );

Map<String, dynamic> _$EnvironmentToJson(Environment instance) =>
    <String, dynamic>{
      'countViewsInVer': instance.countViewsInVer,
      'countViewsInHor': instance.countViewsInHor,
      'seconds': instance.seconds,
    };
