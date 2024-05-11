import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mydota/model/list_team_players_model.dart';

class TeamPlayerProvider extends ChangeNotifier {
  List<ListTeamPlayersModel> _players = [];
  bool _isLoading = false;

  List<ListTeamPlayersModel> get players => _players;
  bool get isLoading => _isLoading;

  Future<void> fetchTeamPlayers(int teamId) async {
    try {
      _isLoading = true;
      final response =
          await Dio().get('https://api.opendota.com/api/teams/$teamId/players');
      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data;
        _players = responseData
            .map((player) => ListTeamPlayersModel.fromJson(player))
            .toList();
      } else {
        throw Exception('Failed to load team players');
      }
    } catch (error) {
      throw Exception('Failed to fetch team players: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
