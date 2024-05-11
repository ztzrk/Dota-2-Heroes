import 'package:flutter/material.dart';
import 'package:mydota/utils/colors.dart';
import 'package:mydota/view/screens/home_screen.dart';
import 'package:mydota/view/screens/splash_screen.dart';
import 'package:mydota/view/screens/team_screen.dart';
import 'package:mydota/view_model/list_hero_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => HeroProvider(),
      child: Builder(
        builder: (context) {
          Provider.of<HeroProvider>(context, listen: false).fetchHeroes();
          return const MainApp();
        },
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.primary,
        fontFamily: 'Poppins',
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/team': (context) => const TeamScreen(),
      },
    );
  }
}
