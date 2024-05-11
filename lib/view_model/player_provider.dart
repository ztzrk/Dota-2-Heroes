import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mydota/model/player_model.dart';

class PlayerProvider extends ChangeNotifier {
  PlayerModel? _player;
  bool _isLoading = false;

  PlayerModel? get player => _player;
  bool get isLoading => _isLoading;

  Future<void> fetchPlayer(int accountId) async {
    try {
      _isLoading = true;
      final response =
          await Dio().get('https://api.opendota.com/api/players/$accountId');
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = response.data;
        _player = PlayerModel.fromJson(jsonData);
      } else {
        throw Exception(
            'Failed to load player data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching player data: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
