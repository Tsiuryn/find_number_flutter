import 'dart:convert';

import 'package:find_number/app/config/records.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'environment.dart';

const _env = "ENV";
const _records = "RECORDS";

class Config {
  late final Future<SharedPreferences> _prefs;

  Config() {
    _prefs = SharedPreferences.getInstance();
  }

  Future<Environment> getEnvironment() {
    try {
      return _prefs.then((pref) {
        final envString = pref.getString(_env);
        if (envString == null) {
          return Environment.empty();
        } else {
          final json = jsonDecode(envString);
          return Environment.fromJson(json);
        }
      });
    } catch (e) {
      return Future.value(Environment.empty());
    }
  }

  void setEnvironment(Environment environment) {
    _prefs.then((value) {
      value.setString(_env, jsonEncode(environment.toJson()));
    });
  }

  Future<Records> getRecords() {
    try {
      return _prefs.then((pref) {
        final recString = pref.getString(_records);
        if (recString == null) {
          return Records.empty();
        } else {
          final json = jsonDecode(recString);
          return Records.fromJson(json);
        }
      });
    } catch (e) {
      return Future.value(Records.empty());
    }
  }

  void setRecords(AppRecord record) {
    _prefs.then((value) async {
      final records = await getRecords();
      records.records.add(record);
      value.setString(_records, jsonEncode(records.toJson()));
    });
  }

  void clearRecords() {
    _prefs.then((value) async {
      value.setString(_records, jsonEncode(Records.empty().toJson()));
    });
  }
}
