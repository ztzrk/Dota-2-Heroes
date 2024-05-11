import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mydota/model/list_team_model.dart';
import 'package:mydota/model/list_team_players_model.dart';
import 'package:mydota/model/player_model.dart';
import 'package:mydota/view_model/list_team_players_provider.dart';
import 'package:mydota/view_model/player_provider.dart';

class TeamDetailScreen extends StatefulWidget {
  const TeamDetailScreen({Key? key}) : super(key: key);

  @override
  TeamDetailScreenState createState() => TeamDetailScreenState();
}

class TeamDetailScreenState extends State<TeamDetailScreen> {
  late Future<List<ListTeamPlayersModel>> _futureTeamPlayers;
  late ListTeamModel _team;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _team = ModalRoute.of(context)!.settings.arguments as ListTeamModel;
    _futureTeamPlayers = fetchTeamPlayers(_team.teamId as int);
  }

  Future<List<ListTeamPlayersModel>> fetchTeamPlayers(int teamId) async {
    final provider = TeamPlayerProvider();
    await provider.fetchTeamPlayers(teamId);
    return provider.players;
  }

  Future<PlayerModel?> fetchPlayer(int accountId) async {
    final provider = PlayerProvider();
    await provider.fetchPlayer(accountId);
    return provider.player;
  }

  double calculateWinProbability(int wins, int losses) {
    if (wins + losses == 0) {
      return 0.0;
    } else {
      return wins / (wins + losses);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_team.name ?? ''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FutureBuilder<List<ListTeamPlayersModel>>(
          future: _futureTeamPlayers,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final players = snapshot.data ?? [];
              final hasCurrentTeamMembers =
                  players.any((player) => player.isCurrentTeamMember == true);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_team.logoUrl != null)
                    Image.network(
                      _team.logoUrl!,
                      width: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return Placeholder(
                          fallbackHeight: 200,
                          fallbackWidth: 200,
                          color: Colors.black,
                        );
                      },
                    ),
                  SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Wins: ${_team.wins}',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Losses: ${_team.losses}',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Team Member',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  Expanded(
                    child: hasCurrentTeamMembers
                        ? ListView.builder(
                            itemCount: players.length,
                            itemBuilder: (context, index) {
                              final player = players[index];
                              if (player.isCurrentTeamMember == true) {
                                return FutureBuilder<PlayerModel?>(
                                  future: fetchPlayer(player.accountId!),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      final playerData = snapshot.data;
                                      if (playerData != null) {
                                        return ListTile(
                                          leading: Image.network(
                                            'https://flagcdn.com/w160/${playerData.profile!.loccountrycode != null ? playerData.profile!.loccountrycode?.toLowerCase() : ''}.png',
                                            width: 100,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return const SizedBox(
                                                width: 100,
                                                child: Icon(
                                                  Icons.error_outline,
                                                  size: 50,
                                                  color: Colors.grey,
                                                ),
                                              );
                                            },
                                          ),
                                          title: Text(
                                              playerData.profile?.name ?? ''),
                                          subtitle: Text(
                                              playerData.profile?.personaname ??
                                                  ''),
                                        );
                                      } else {
                                        return const SizedBox();
                                      }
                                    }
                                  },
                                );
                              }
                              return const SizedBox();
                            },
                          )
                        : Center(
                            child: Text(
                              'This team is disbanded',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
