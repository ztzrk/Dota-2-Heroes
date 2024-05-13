import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mydota/model/list_hero_model.dart';

class ListHeroProvider extends ChangeNotifier {
  List<ListHeroModel> _heroes = [];
  bool _isLoading = false;
  List<String> selectedFilters = [];

  List<ListHeroModel> get heroes => _heroes;
  bool get isLoading => _isLoading;
  bool get isNoFilterSelected => selectedFilters.isEmpty;

  void addFilter(String filter) {
    if (!selectedFilters.contains(filter)) {
      selectedFilters.add(filter);
      notifyListeners();
    }
  }

  void removeFilter(String filter) {
    if (selectedFilters.contains(filter)) {
      selectedFilters.remove(filter);
      notifyListeners();
    }
  }

  bool isFilterSelected(String filter) {
    return selectedFilters.contains(filter);
  }

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

  List<ListHeroModel> getFilteredHeroes() {
    if (selectedFilters.isEmpty) {
      return _heroes;
    } else {
      List<ListHeroModel> filteredList = _heroes;

      if (!selectedFilters.contains('str') &&
          !selectedFilters.contains('int') &&
          !selectedFilters.contains('all') &&
          !selectedFilters.contains('agi')) {
        filteredList = filteredList.where((hero) {
          return selectedFilters.contains(hero.attackType);
        }).toList();
      } else if (selectedFilters.contains('Melee') ||
          selectedFilters.contains('Ranged')) {
        filteredList = filteredList.where((hero) {
          bool passesAttackTypeFilter = true;

          if (selectedFilters.contains('Melee')) {
            passesAttackTypeFilter = hero.attackType!.contains('Melee');
          } else if (selectedFilters.contains('Ranged')) {
            passesAttackTypeFilter = hero.attackType!.contains('Ranged');
          }

          return passesAttackTypeFilter &&
              (selectedFilters.isEmpty ||
                  selectedFilters.contains(hero.primaryAttr));
        }).toList();
      } else {
        filteredList = filteredList.where((hero) {
          return selectedFilters.contains(hero.primaryAttr);
        }).toList();
      }

      return filteredList;
    }
  }

  void clearFilters() {
    selectedFilters.clear();
    notifyListeners();
  }
}
