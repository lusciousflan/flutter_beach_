import 'package:flutter/material.dart';
import 'package:flutter_beach/tournament_current_page.dart';
import 'package:flutter_beach/tournament_summary_page.dart';
import 'package:audioplayers/audioplayers.dart';

int teamNumber = 3;
final _audio = AudioCache();

class TournamentPage extends StatefulWidget {
  const TournamentPage({super.key});

  @override
  State<TournamentPage> createState() => _TournamentPageState();
}

class _TournamentPageState extends State<TournamentPage> {
  void teamNumberSelect(int n) {
    _audio.play('a.mp3');
    teamNumber = n;
    matchList[0][0] = 0;
    matchList[0][1] = 1;
    matchCount[0]++;
    matchCount[1]++;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return const TournamentSummaryPage();
        },
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(children: [
          const Text('チーム数選択', style: TextStyle(fontSize: 48)),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              teamNumberSelect(3);
            },
            child: const Text(
              '3チーム', 
              style: TextStyle(fontSize: 48),
            ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: (){
              teamNumberSelect(4);
            }, 
            child: const Text(
              '4チーム', 
              style: TextStyle(fontSize: 48),
            ),
          ),
          const Spacer(),
        ],
        ),
      ));
  }
}