// import 'dart:async';
// import 'dart:convert';
// import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../logger.dart';
//
// class AppPreferences {
//   final tag = "AppPreferences";
//
//   AppPreferences._() {
//   }
//
//   static AppPreferences instance = AppPreferences._();
//   static SharedPreferences? _sharedPreferences;
//
//   Future<void> init() async {
//     _sharedPreferences ??= await SharedPreferences.getInstance();
//   }
//
//   Future<bool?> clear() async {
//     return await _sharedPreferences?.clear();
//   }
//
//   Future<bool> _saveString(String key, String? value) {
//     return _sharedPreferences!.setString(key, value ?? "");
//   }
//
//   String? _getString(String key) {
//     return _sharedPreferences!.getString(key);
//   }
//
//   // Response<dynamic>? _getObject(String key) {
//   //   return _sharedPreferences!.getStringList(key);
//   // }
//
//   ///************************************************************************************************************///
//   ///********************************////* Write App Specific methods here *////********************************///
//   ///************************************************************************************************************///
//   ///
//
//   Future<bool> storeResponseCache(Response<dynamic> value) {
//     return _saveString("responseCache", jsonEncode(value));
//   }
//   //
//   // Response<dynamic> ? get cacheResponse => _getString("responseCache");
//
// }
