import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'environment.dart';

const _env = "ENV";

class Config {
  late final Future<SharedPreferences> _prefs;

   Config() {
    _prefs = SharedPreferences.getInstance();
  }

  Future<Environment> getEnvironment() {
    return _prefs.then((pref) {
      final envString =  pref.getString(_env);
      if(envString == null){
        return Environment.empty();
      }else{
        final json = jsonDecode(envString);
        return Environment.fromJson(json);
      }
    });
  }

  void setEnvironment (Environment environment){
    _prefs.then((value){
      value.setString(_env, jsonEncode(environment.toJson()));
    });
  }

}