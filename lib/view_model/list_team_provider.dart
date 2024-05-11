import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mydota/model/list_team_model.dart';

class ListTeamProvider extends ChangeNotifier {
  List<ListTeamModel> _teams = [];
  bool _isLoading = false;

  List<ListTeamModel> get teams => _teams;
  bool get isLoading => _isLoading;

  Future<void> fetchTeams() async {
    try {
      _isLoading = true;
      final response = await Dio().get('https://api.opendota.com/api/teams');
      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data;
        _teams =
            responseData.map((team) => ListTeamModel.fromJson(team)).toList();
        _teams.sort((a, b) => a.name!.compareTo(b.name!));
      } else {
        throw Exception('Failed to load teams');
      }
    } catch (error) {
      throw Exception('Failed to fetch teams: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
