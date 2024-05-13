import 'package:flutter/material.dart';
import 'package:mydota/view_model/database_helper.dart';

class DatabaseProvider extends ChangeNotifier {
  late DatabaseHelper _databaseHelper;

  DatabaseProvider() {
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    _databaseHelper = DatabaseHelper();
    await _databaseHelper.initDatabase();
    notifyListeners();
  }

  DatabaseHelper get databaseHelper => _databaseHelper;
}
