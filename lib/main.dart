import 'package:flutter/material.dart';
import 'package:mydota/utils/colors.dart';
import 'package:mydota/view/screens/home_screen.dart';
import 'package:mydota/view/screens/player_screen.dart';
import 'package:mydota/view/screens/splash_screen.dart';
import 'package:mydota/view/screens/team_detail_screen.dart';
import 'package:mydota/view/screens/team_screen.dart';
import 'package:mydota/view_model/database_helper.dart';
import 'package:mydota/view_model/list_hero_provider.dart';
import 'package:mydota/view_model/list_player_provider.dart';
import 'package:mydota/view_model/list_team_provider.dart';
import 'package:provider/provider.dart';

void main() {
  final databaseHelper = DatabaseHelper();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ListHeroProvider()),
        ChangeNotifierProvider(create: (_) => ListTeamProvider()),
        ChangeNotifierProvider(create: (_) => ListPlayerProvider()),
        Provider.value(value: databaseHelper),
      ],
      child: Builder(
        builder: (context) {
          Provider.of<ListHeroProvider>(context, listen: false).fetchHeroes();
          Provider.of<ListTeamProvider>(context, listen: false).fetchTeams();
          Provider.of<ListPlayerProvider>(context, listen: false)
              .fetchPlayers();
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
        '/player': (context) => const PlayerScreen(),
        '/team/detail': (context) => const TeamDetailScreen(),
      },
    );
  }
}
