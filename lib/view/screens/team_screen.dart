import 'package:flutter/material.dart';
import 'package:mydota/view/widgets/bottom_nav.dart';

class TeamScreen extends StatefulWidget {
  const TeamScreen({super.key});

  @override
  State<TeamScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  final int _selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: _selectedIndex,
      ),
    );
  }
}
