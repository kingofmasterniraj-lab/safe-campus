import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const _userKey = 'sc_user';
  static const _pointsKey = 'sc_points';
  static const _drillsCountKey = 'sc_drills_count';
  static const _prepScoreKey = 'sc_prep_score';

  Future<void> saveUser(Map<String, dynamic> user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(user));
  }

  Future<Map<String, dynamic>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final str = prefs.getString(_userKey);
    if (str == null) return null;
    return jsonDecode(str) as Map<String, dynamic>;
  }

  Future<int> getPoints() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_pointsKey) ?? 0;
  }

  Future<void> addPoints(int delta) async {
    final prefs = await SharedPreferences.getInstance();
    final current = prefs.getInt(_pointsKey) ?? 0;
    await prefs.setInt(_pointsKey, current + delta);
    await _recomputePrepScore();
  }

  Future<int> getDrillsCount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_drillsCountKey) ?? 0;
  }

  Future<void> incrementDrills() async {
    final prefs = await SharedPreferences.getInstance();
    final current = prefs.getInt(_drillsCountKey) ?? 0;
    await prefs.setInt(_drillsCountKey, current + 1);
    await _recomputePrepScore();
  }

  Future<int> getPrepScore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_prepScoreKey) ?? 0;
  }

  Future<void> _recomputePrepScore() async {
    final prefs = await SharedPreferences.getInstance();
    final points = prefs.getInt(_pointsKey) ?? 0;
    final drills = prefs.getInt(_drillsCountKey) ?? 0;
    final score = (points ~/ 10) + (drills * 5);
    await prefs.setInt(_prepScoreKey, score);
  }

  Future<void> reset() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
