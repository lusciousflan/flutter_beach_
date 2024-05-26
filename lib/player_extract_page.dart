import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_beach/home_page.dart';
import 'package:flutter_beach/player_history_page.dart';
import 'package:flutter_beach/player_switch_page.dart';
import 'package:audioplayers/audioplayers.dart';

int historyNumber = 0;
int restingNumber = 0;
final _audio = AudioCache();
List<List> tokorotenHistory = [[]];
List<bool> isSwitch = List.generate(numberOfPlayer, (i) => true);

class PlayerExtractPage extends StatefulWidget {
  const PlayerExtractPage({super.key});

  @override
  State<PlayerExtractPage> createState() => _PlayerExtractPageState();
}

class _PlayerExtractPageState extends State<PlayerExtractPage> {
  int extractNumber = 8;
  var tokoroten = Queue();
  List tokorotenList = [];

  void extractButton() {
    setState(() {
      //List tokorotenList = [];
      if (tokoroten.length < extractNumber + restingNumber) {
        playerList.shuffle();
        tokoroten.addAll(playerList);
      }
      tokorotenList = [];
      List<bool> check = [];
      for (int j = 0; j < numberOfPlayer; j++) {
        check.add(true);
      }
      for (int i = 0; i < extractNumber; i++) {
        if(isSwitch[tokoroten.first-1] == false) {
          debugPrint('休憩中 ${tokoroten.first}');
          tokoroten.removeFirst();
          i--;
        } else if (check[tokoroten.first - 1] == true) {
          tokorotenList.add(tokoroten.first);
          playCount[tokoroten.first - 1]++;
          check[tokoroten.first - 1] = false;
          tokoroten.removeFirst();
        } else {
          debugPrint('抽出重複 ${tokoroten.first}');
          tokoroten.addLast(tokoroten.first);
          tokoroten.removeFirst();
          i--;
        }
      }
      tokorotenHistory.add(tokorotenList);
      _audio.play('a.mp3');
      historyNumber++;
      debugPrint('$playCount');
    });
  }
  void shuffleButton() {
    setState(() {
      tokorotenList.shuffle();
      _audio.play('d.mp3');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('参加者抽出'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(children: <Widget>[
          Text('参加者$numberOfPlayer人', style: const TextStyle(fontSize: 24)),
          const Text('抽出数', style: TextStyle(fontSize: 24)),
          TextField(
            maxLength: 2,
            textAlign: TextAlign.center,
            controller: TextEditingController(text: '$extractNumber'),
            style: const TextStyle(
              fontSize: 36,
            ),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            onChanged: (text) {
              extractNumber = int.parse(text);
              debugPrint('$extractNumber');
            },
          ),
          Flexible(
            child: Text(
              '$tokorotenList',
              style: const TextStyle(fontSize: 30),
            ),
          ),
          const Spacer(),
          Row(children: <Widget>[
            //Center(
              const Spacer(),
              ElevatedButton(
                onPressed: extractButton,
                child: const Text(
                  '抽出',
                  style: TextStyle(fontSize: 48),
                )
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: shuffleButton,
                child: const Text(
                  'shuffle',
                  style: TextStyle(fontSize: 24),
                )
              ),
              //const Spacer(),
            //)
          ]),
          const Spacer(),
          ElevatedButton(
              onPressed: () {
                _audio.play('b.mp3');
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const PlayerSwitchPage();
                    },
                  ),
                );
              },
              child: const Text(
                '参加者切替',
                style: TextStyle(fontSize: 48),
              )),
          const Spacer(),
          ElevatedButton(
              onPressed: () {
                _audio.play('b.mp3');
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const PlayerHistoryPage();
                    },
                  ),
                );
              },
              child: const Text(
                '履歴',
                style: TextStyle(fontSize: 48),
              )),
          const Spacer(),
          ElevatedButton(
              onPressed: () {
                _audio.play('e.mp3');
                setState(() {
                  numberOfPlayer++;
                  playerList.add(numberOfPlayer);
                  playCount.add(0);
                  isSwitch.add(true);
                  debugPrint('1人増やす');
                });
              },
              child: const Text(
                '1人増やす',
                style: TextStyle(fontSize: 48),
              )),
          const Spacer(),
        ]),
      ),
    );
  }
}
