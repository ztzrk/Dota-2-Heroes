import 'package:flutter/material.dart';
import 'package:mydota/model/list_player_model.dart';
import 'package:mydota/view/widgets/app_bar.dart';
import 'package:mydota/view/widgets/bottom_nav.dart';
import 'package:mydota/view/widgets/skeleton_loading.dart';
import 'package:mydota/view_model/list_player_provider.dart';
import 'package:provider/provider.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  PlayerScreenState createState() => PlayerScreenState();
}

class PlayerScreenState extends State<PlayerScreen> {
  final int _selectedIndex = 2;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    Future.microtask(() {
      Provider.of<ListPlayerProvider>(context, listen: false).fetchPlayers();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<ListPlayerModel> _filterPlayers(
      String query, List<ListPlayerModel> players) {
    return players.where((player) {
      final name = player.name ?? '';
      return name.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: Consumer<ListPlayerProvider>(
              builder: (context, listTeamProvider, _) {
                if (listTeamProvider.isLoading &&
                    listTeamProvider.players.isEmpty) {
                  return buildSkeletonLoadingScreen();
                } else {
                  final players = _searchController.text.isEmpty
                      ? listTeamProvider.players
                      : _filterPlayers(
                          _searchController.text, listTeamProvider.players);

                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: players.length,
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
                    itemBuilder: (BuildContext context, int index) {
                      final player = players[index];
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
                                    player.avatarfull ?? '',
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
                                player.name ?? '',
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
          ),
        ],
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: _selectedIndex,
      ),
    );
  }
}
