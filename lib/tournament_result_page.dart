import 'package:flutter/material.dart';
import 'package:flutter_beach/tournament_page.dart';
import 'package:flutter_beach/tournament_current_page.dart';
import 'package:flutter_beach/tournament_summary_page.dart';
import 'package:audioplayers/audioplayers.dart';

List<List<int>> finalRank = List.generate(4, (index) => [0, 0, index]);
final _audio = AudioCache();

class TournamentResultPage extends StatefulWidget {
  const TournamentResultPage({super.key});

  @override
  State<TournamentResultPage> createState() => _TournamentResultPageState();
}

class _TournamentResultPageState extends State<TournamentResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: [
            const Text('大会モード', style: TextStyle(fontSize: 48),),
            const Text('試合終了', style: TextStyle(fontSize: 36),),
            const Spacer(),
            Row(
              children: const[
                Text('順位', style: TextStyle(fontSize: 36),),
                Spacer(),
                Text('チーム', style: TextStyle(fontSize: 36),),
                Spacer(),
                Text('勝数', style: TextStyle(fontSize: 36),),
                Spacer(),
                Text('失点', style: TextStyle(fontSize: 36),),
              ],),
            for(int i = 0; i < teamNumber; i++) ...{
              Row(
                children: [
                  Text('${i+1}位', style: const TextStyle(fontSize: 48),),
                  const Spacer(),
                  Text('${teams[finalRank[i][2]]}', style: const TextStyle(fontSize: 48),),
                  const Spacer(),
                  Text('${finalRank[i][0]}', style: const TextStyle(fontSize: 48),),
                  const Spacer(),
                  Text('${finalRank[i][1]}', style: const TextStyle(fontSize: 48),),
                ],),
                const Spacer(),
            },
            ElevatedButton(
              onPressed: (){
                _audio.play('d.mp3');
                finalRank = List.generate(4, (index) => [0, 0, index]);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const TournamentSummaryPage();
                    },
                  ),
                );
              }, 
              child: const Text('修正', style: TextStyle(fontSize: 36),),
            ),
            const Spacer(),
          ]
        )
      )
    );
  }
}