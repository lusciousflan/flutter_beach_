import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_beach/tournament_summary_page.dart';
import 'package:flutter_beach/tournament_page.dart';
import 'package:flutter_beach/tournament_result_page.dart';
import 'package:audioplayers/audioplayers.dart';

List<int> matchCount = List.generate(teamNumber, (index) => 0);
List teams = ['A', 'B', 'C', 'D'];
List<int> winlose = List.generate(4, (index) => 4);
final _audio = AudioCache();

void resultWarp() {
  for (int i = 0; i < 6; i++) {
    //勝ち数と失点を数える
    if (matchResult[i][0] > matchResult[i][1]) {
      finalRank[matchList[i][0]][0]++;
      finalRank[matchList[i][1]][1] += matchResult[i][0] - matchResult[i][1];
    } else {
      finalRank[matchList[i][1]][0]++;
      finalRank[matchList[i][0]][1] += matchResult[i][1] - matchResult[i][0];
    }
  }
  finalRank.sort((a, b) {
    int result = -a[0].compareTo(b[0]);
    if (result != 0) return result;
    return a[1].compareTo(b[1]);
  });
}

class TournamentCurrentPage extends StatefulWidget {
  const TournamentCurrentPage({super.key});

  @override
  State<TournamentCurrentPage> createState() => _TournamentCurrentPageState();
}

class _TournamentCurrentPageState extends State<TournamentCurrentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Center(
          child: Column(
        children: [
          const Text(
            '大会モード',
            style: TextStyle(fontSize: 48),
          ),
          Text(
            '第$matchNumber試合',
            style: const TextStyle(fontSize: 36),
          ),
          const Spacer(),
          Row(
            children: [
              const Spacer(),
              if (matchList[matchNumber - 1][0] != 4) ...{
                Text(
                  '${teams[matchList[matchNumber - 1][0]]}',
                  style: const TextStyle(fontSize: 48),
                ),
              } else
                const Text(' '),
              const Spacer(),
              const Text(
                '対',
                style: TextStyle(fontSize: 48),
              ),
              const Spacer(),
              if (matchList[matchNumber - 1][1] != 4) ...{
                Text(
                  '${teams[matchList[matchNumber - 1][1]]}',
                  style: const TextStyle(fontSize: 48),
                ),
              } else
                const Text(' '),
              const Spacer(),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              const Spacer(),
              Flexible(
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  style: const TextStyle(fontSize: 48),
                  onChanged: (text) {
                    setState(() {
                      matchResult[matchNumber - 1][0] = int.parse(text);
                      debugPrint('${matchResult[matchNumber - 1][0]}');
                    });
                  },
                  controller: TextEditingController(
                      text: '${matchResult[matchNumber - 1][0]}'),
                ),
              ),
              const Spacer(),
              const Spacer(),
              Flexible(
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  style: const TextStyle(fontSize: 48),
                  onChanged: (text) {
                    setState(() {
                      matchResult[matchNumber - 1][1] = int.parse(text);
                      debugPrint('${matchResult[matchNumber - 1][1]}');
                    });
                  },
                  controller: TextEditingController(
                      text: '${matchResult[matchNumber - 1][1]}'),
                ),
              ),
              const Spacer(),
            ],
          ),
          const Spacer(),
          ElevatedButton(
              onPressed: () {
                _audio.play('e.mp3');
                if (teamNumber == 3) {
                  if (matchNumber < 3) {
                    List tmp = [];
                    for (int i = 0; i < teamNumber; i++) {
                      if (matchCount[i] == matchCount.reduce(min)) {
                        tmp.add(i);
                      }
                    }
                    debugPrint('$tmp');
                    if (tmp.length == 1) {
                      matchList[matchNumber][1] = tmp[0];
                      matchCount[tmp[0]]++;
                      if (matchResult[matchNumber - 1][0] >
                          matchResult[matchNumber - 1][1]) {
                        matchList[matchNumber][0] = matchList[matchNumber - 1][0];
                        matchCount[matchList[matchNumber][0]]++;
                      } else {
                        matchList[matchNumber][0] = matchList[matchNumber - 1][1];
                        matchCount[matchList[matchNumber][0]]++;
                      }
                    } else {
                      matchList[matchNumber][0] = tmp[0];
                      matchList[matchNumber][1] = tmp[1];
                      matchCount[tmp[0]]++;
                      matchCount[tmp[1]]++;
                    }
                    if (matchNumber == 2) {
                      for (int i = 0; i < 3; i++) {
                        matchList[i + 3][0] = matchList[i][0];
                        matchList[i + 3][1] = matchList[i][1];
                      }
                    }
                  }
                } if(teamNumber == 4) {
                  debugPrint("$matchNumber");
                  if(matchNumber < 3) {
                    for(int i = 0; i < 2; i++) {
                      matchList[i][0] = 2*i;
                      matchList[i][1] = 2*i+1;
                    }
                  }
                  if(matchNumber == 2) {
                    for(int i = 0; i < 2; i++) {
                      if(matchResult[i][0] > matchResult[i][1]) {
                        winlose[i] = matchList[i][0];
                        winlose[2+i] = matchList[i][1];
                      } else {
                        winlose[i] = matchList[i][1];
                        winlose[2+i] = matchList[i][0];
                      }
                    }
                    matchList[2][0] = winlose[0];
                    matchList[2][1] = winlose[1];
                    matchList[3][0] = winlose[2];
                    matchList[3][1] = winlose[3];
                    matchList[4][0] = winlose[0];
                    matchList[4][1] = winlose[3];
                    matchList[5][0] = winlose[1];
                    matchList[5][1] = winlose[2];
                  
                  }
                }
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const TournamentSummaryPage();
                    },
                  ),
                );
              },
              child: const Text(
                '入力完了',
                style: TextStyle(fontSize: 48),
              )),
          const Spacer(),
        ],
      )),
    );
  }
}
