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
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              'https://cdn.dota2.com/apps/dota2/images/heroes/${hero.localizedName?.toLowerCase().replaceAll(' ', '_').replaceAll('-', '') ?? 'unknown'}_lg.png',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.black,
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          hero.localizedName ?? '',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
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
