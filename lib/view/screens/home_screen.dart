import 'package:flutter/material.dart';
import 'package:mydota/view/widgets/app_bar.dart';
import 'package:mydota/view/widgets/bottom_nav.dart';
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

  bool noFilterSelected = true;
  Map<String, bool> filterStates = {
    'str': false,
    'agi': false,
    'int': false,
    'all': false,
    'melee': false,
    'ranged': false,
  };

  List<String> selectedFilters = ['all'];

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
              final filteredHeroes = listHeroProvider.heroes.where((hero) {
                if (noFilterSelected) {
                  return true;
                } else {
                  bool primaryAttrMatch = filterStates[hero.primaryAttr]!;
                  bool attackTypeMatch = false;

                  bool meleeSelected = filterStates['melee']!;
                  bool rangedSelected = filterStates['ranged']!;
                  if (meleeSelected || rangedSelected) {
                    attackTypeMatch =
                        (meleeSelected && hero.attackType == 'Melee') ||
                            (rangedSelected && hero.attackType == 'Ranged');
                  } else {
                    attackTypeMatch = true;
                  }
                  if (!(filterStates['str']! ||
                      filterStates['agi']! ||
                      filterStates['int']! ||
                      filterStates['all']!)) {
                    primaryAttrMatch = true;
                  }

                  return primaryAttrMatch && attackTypeMatch;
                }
              }).toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FilterChip(
                    label: const Text('All'),
                    selected: noFilterSelected,
                    onSelected: (selected) {
                      setState(() {
                        noFilterSelected = selected;
                        if (selected) {
                          filterStates.forEach((key, _) {
                            filterStates[key] = false;
                          });
                        }
                      });
                    },
                  ),
                  const Text('Primary Attribute'),
                  Wrap(
                    spacing: 8,
                    children: [
                      FilterChip(
                        label: const Text('Strength'),
                        selected: filterStates['str']!,
                        onSelected: (selected) {
                          setState(() {
                            filterStates['str'] = selected;
                            if (selected) {
                              filterStates['agi'] = false;
                              filterStates['int'] = false;
                              filterStates['all'] = false;
                            }
                            noFilterSelected = false;
                          });
                        },
                      ),
                      FilterChip(
                        label: const Text('Agility'),
                        selected: filterStates['agi']!,
                        onSelected: (selected) {
                          setState(() {
                            filterStates['agi'] = selected;
                            if (selected) {
                              filterStates['str'] = false;
                              filterStates['int'] = false;
                              filterStates['all'] = false;
                            }
                            noFilterSelected = false;
                          });
                        },
                      ),
                      FilterChip(
                        label: const Text('Intelligence'),
                        selected: filterStates['int']!,
                        onSelected: (selected) {
                          setState(() {
                            filterStates['int'] = selected;
                            if (selected) {
                              filterStates['str'] = false;
                              filterStates['agi'] = false;
                              filterStates['all'] = false;
                            }
                            noFilterSelected = false;
                          });
                        },
                      ),
                      FilterChip(
                        label: const Text('Universal'),
                        selected: filterStates['all']!,
                        onSelected: (selected) {
                          setState(() {
                            filterStates['all'] = selected;
                            if (selected) {
                              filterStates['str'] = false;
                              filterStates['agi'] = false;
                              filterStates['int'] = false;
                            }
                            noFilterSelected = false;
                          });
                        },
                      ),
                    ],
                  ),
                  const Text('Attack Type'),
                  Wrap(
                    spacing: 8,
                    children: [
                      FilterChip(
                        label: const Text('Melee'),
                        selected: filterStates['melee']!,
                        onSelected: (selected) {
                          setState(() {
                            filterStates['melee'] = selected;
                            if (selected) {
                              filterStates['ranged'] = false;
                            }
                            noFilterSelected = false;
                          });
                        },
                      ),
                      FilterChip(
                        label: const Text('Ranged'),
                        selected: filterStates['ranged']!,
                        onSelected: (selected) {
                          setState(() {
                            filterStates['ranged'] = selected;
                            if (selected) {
                              filterStates['melee'] = false;
                            }
                            noFilterSelected = false;
                          });
                        },
                      ),
                    ],
                  ),
                  Expanded(
                    child: filteredHeroes.isEmpty
                        ? const Center(
                            child: Text(
                              'No heroes found for the selected filters.',
                              style: TextStyle(fontSize: 18),
                            ),
                          )
                        : GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                            ),
                            itemCount: filteredHeroes.length,
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              final hero = filteredHeroes[index];
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
                                        errorBuilder:
                                            (context, error, stackTrace) {
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
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: colorAttr[
                                                            hero.primaryAttr],
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
                                                      textAlign:
                                                          TextAlign.center,
                                                      overflow:
                                                          TextOverflow.fade,
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                          ),
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
