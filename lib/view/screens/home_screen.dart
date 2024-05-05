import 'package:flutter/material.dart';
import 'package:mydota/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: 8,
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 200,
            child: Column(
              children: [
                Expanded(
                  child: Image.asset('assets/dpc.png'),
                ),
                const Text('Axe'),
              ],
            ),
          );
        },
      ),
    );
  }
}
