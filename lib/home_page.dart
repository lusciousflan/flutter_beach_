import 'package:flutter/material.dart';
import 'package:flutter_beach/number_lottery_page.dart';
import 'package:flutter_beach/player_extract_page.dart';
import 'package:flutter_beach/tournament_page.dart';
import 'package:audioplayers/audioplayers.dart';


int numberOfPlayer = 0;
final _audio = AudioCache();
List<int> playerList = [];
List<int> playCount = List.generate(numberOfPlayer, (i) => 0);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            children: [
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  debugPrint('番号抽選');
                  playerList.clear();
                  _audio.play('b.mp3');
                  for (int i = 0; i < numberOfPlayer; i++) {
                    playerList.add(i + 1);
                  }
                  playerList.shuffle();
                  debugPrint('$playerList');
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const NumberLotteryPage();
                      },
                    ),
                  );
                },
                child: const Text(
                  '番号抽選',
                  style: TextStyle(fontSize: 48),
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  _audio.play('b.mp3');
                  debugPrint('参加者抽出');
                  playCount = List.generate(numberOfPlayer, (i) => 0);
                  historyNumber = 0;
                  tokorotenHistory = [[]];
                  isSwitch = List.generate(numberOfPlayer, (i) => true);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const PlayerExtractPage();
                      },
                    ),
                  );
                },
                child: const Text(
                  '練習モード',
                  style: TextStyle(fontSize: 48),
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: (){
                  debugPrint('大会モード');
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const TournamentPage();
                      },
                    ),
                  );
                }, 
                child: const Text('大会モード', style: TextStyle(fontSize: 48))
                ),
                const Spacer(),
            ],
          ),
        ));
  }
}
