import 'package:flutter/material.dart';
import 'package:mydota/utils/colors.dart';

class MyBottomNavigationBar extends StatelessWidget {
  final int currentIndex;

  const MyBottomNavigationBar({
    super.key,
    required this.currentIndex,
  });

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        Navigator.pushNamed(context, '/team');
        break;
      case 2:
        Navigator.pushNamed(context, '/player');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_rounded),
          label: 'Heroes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.group),
          label: 'Team',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Player',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favorite',
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: AppColors.fourth,
      unselectedItemColor: AppColors.third,
      backgroundColor: Colors.amber,
      onTap: (index) {
        _onItemTapped(context, index);
      },
    );
  }
}
