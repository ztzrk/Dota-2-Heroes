import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mydota/model/list_player_model.dart';

class ListPlayerProvider extends ChangeNotifier {
  List<ListPlayerModel> _players = [];
  bool _isLoading = false;

  List<ListPlayerModel> get players => _players;
  bool get isLoading => _isLoading;

  Future<void> fetchPlayers() async {
    try {
      _isLoading = true;
      final response =
          await Dio().get('https://api.opendota.com/api/proPlayers');
      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data;
        _players = responseData
            .map((player) => ListPlayerModel.fromJson(player))
            .toList();
        _players.sort((a, b) => a.name!.compareTo(b.name!));
      } else {
        throw Exception('Failed to load players');
      }
    } catch (error) {
      throw Exception('Failed to fetch players: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
