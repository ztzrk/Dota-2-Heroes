import 'package:flutter/material.dart';
import 'package:mydota/utils/colors.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.fourth,
      leading: Padding(
        padding: const EdgeInsets.all(8),
        child: Image.asset(
          'assets/dpc.png',
        ),
      ),
      title: const Text(
        'MyDota',
        style: TextStyle(color: AppColors.primary),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
