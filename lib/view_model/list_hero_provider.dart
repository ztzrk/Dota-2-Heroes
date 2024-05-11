import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mydota/model/list_hero_model.dart';

class HeroProvider extends ChangeNotifier {
  List<ListHeroModel> _heroes = [];
  bool _isLoading = false;

  List<ListHeroModel> get heroes => _heroes;
  bool get isLoading => _isLoading;

  Future<void> fetchHeroes() async {
    try {
      _isLoading = true;
      final response = await Dio().get('https://api.opendota.com/api/heroes');
      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data;
        _heroes =
            responseData.map((hero) => ListHeroModel.fromJson(hero)).toList();

        _heroes.sort((a, b) => a.localizedName!.compareTo(b.localizedName!));
      } else {
        throw Exception('Failed to load heroes');
      }
    } catch (error) {
      throw Exception('Failed to fetch heroes: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
