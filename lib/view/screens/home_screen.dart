import 'package:flutter/material.dart';
import 'package:mydota/view/widgets/app_bar.dart';
import 'package:mydota/view/widgets/bottom_nav.dart';
import 'package:mydota/view/widgets/hero_filter_chip.dart';
import 'package:mydota/view/widgets/heroes_grid_view.dart';
import 'package:mydota/view/widgets/skeleton_loading.dart';
import 'package:mydota/view_model/list_hero_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final int _selectedIndex = 0;

  bool noSelected = true;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ListHeroProvider>(context, listen: false).fetchHeroes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Consumer<ListHeroProvider>(
          builder: (context, listHeroProvider, _) {
            if (listHeroProvider.isLoading && listHeroProvider.heroes.isEmpty) {
              return buildSkeletonLoadingScreen();
            } else {
              final filteredHeroes = listHeroProvider.getFilteredHeroes();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeroFilter(listHeroProvider: listHeroProvider),
                  Expanded(
                    child: filteredHeroes.isEmpty
                        ? const Center(
                            child: Text(
                              'No heroes found for the selected filters.',
                              style: TextStyle(fontSize: 18),
                            ),
                          )
                        : HeroesGridView(heroes: filteredHeroes),
                  ),
                ],
              );
            }
          },
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: _selectedIndex,
      ),
    );
  }
}
