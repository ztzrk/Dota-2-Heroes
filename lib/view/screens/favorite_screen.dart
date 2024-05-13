import 'package:flutter/material.dart';
import 'package:mydota/model/list_team_model.dart';
import 'package:mydota/view/widgets/app_bar.dart';
import 'package:mydota/view/widgets/bottom_nav.dart';
import 'package:mydota/view_model/database_helper.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final _selectedIndex = 3;
  late List<ListTeamModel> _favoriteTeams = [];

  @override
  void initState() {
    super.initState();
    _fetchFavoriteTeams();
  }

  Future<void> _fetchFavoriteTeams() async {
    final databaseHelper = DatabaseHelper();
    final teams = await databaseHelper.getTeams();
    setState(() {
      _favoriteTeams = teams;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: _favoriteTeams.isEmpty
          ? const Center(
              child: Text('No favorite teams found.'),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: _favoriteTeams.length,
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
              itemBuilder: (BuildContext context, int index) {
                final team = _favoriteTeams[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/team/detail',
                      arguments: team,
                    );
                  },
                  child: Card(
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
                                team.logoUrl ?? '',
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
                            team.name ?? '',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: _selectedIndex,
      ),
    );
  }
}
