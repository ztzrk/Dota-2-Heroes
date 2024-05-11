import 'package:flutter/material.dart';
import 'package:mydota/view/widgets/app_bar.dart';
import 'package:mydota/view/widgets/bottom_nav.dart';
import 'package:mydota/view/widgets/skeleton_loading.dart';
import 'package:mydota/view_model/list_hero_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int _selectedIndex = 0;

  Map<String, String> attr = {
    'int': 'hero_intelligence',
    'all': 'hero_universal',
    'str': 'hero_strength',
    'agi': 'hero_agility',
  };

  Map<String, Color> colorAttr = {
    'int': Colors.blue,
    'all': Colors.black,
    'str': Colors.red,
    'agi': Colors.green,
  };

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
      body: Consumer<ListHeroProvider>(
        builder: (context, listHeroProvider, _) {
          if (listHeroProvider.isLoading && listHeroProvider.heroes.isEmpty) {
            return buildSkeletonLoadingScreen();
          } else {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: listHeroProvider.heroes.length,
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
              itemBuilder: (BuildContext context, int index) {
                final hero = listHeroProvider.heroes[index];
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          'https://cdn.dota2.com/apps/dota2/images/heroes/${hero.localizedName?.toLowerCase().replaceAll(' ', '_').replaceAll('-', '') ?? 'unknown'}_vert.jpg',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.account_circle_rounded,
                              color: Colors.grey,
                              size: 120,
                            );
                          },
                        ),
                        Positioned.fill(
                          bottom: 0,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(8),
                              color: Colors.black.withOpacity(0.5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: colorAttr[hero.primaryAttr],
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.network(
                                          'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/icons/${attr[hero.primaryAttr]}.png',
                                          color: Colors.white,
                                          width: 20,
                                          height: 20,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        hero.localizedName ?? '',
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.fade,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: _selectedIndex,
      ),
    );
  }
}
