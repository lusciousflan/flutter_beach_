import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beach/home_page.dart';

class NumberLotteryPage extends StatefulWidget {
  const NumberLotteryPage({super.key});

  @override
  State<NumberLotteryPage> createState() => _NumberLotteryPageState();
}

class _NumberLotteryPageState extends State<NumberLotteryPage> {
  int index = 0;
  int lottery = 0;
  bool isLotteryEnd = false;
  final _audio = AudioCache();

  void incrementCounter() {
    setState(() {
      if (index < numberOfPlayer) {
        lottery = playerList[index];
        debugPrint('抽選 $lottery');
        index++;
        _audio.play('c.mp3');
            } else {
        isLotteryEnd = true;
        debugPrint('抽選おわり');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('番号抽選'),
      ),
      body: Center(
        child: Column(children: <Widget>[
          Text(
            '$numberOfPlayer人中$index番目',
            style: const TextStyle(fontSize: 36),
          ),
          if (lottery != 0)
            Text('$lottery', style: const TextStyle(fontSize: 200))
          else
            const Text(' ', style: TextStyle(fontSize: 200)),
          if (!isLotteryEnd)
            ElevatedButton(
                onPressed: incrementCounter,                
                child: const Text('抽選', style: TextStyle(fontSize: 150)))
          else
            const Text('おわり', style: TextStyle(fontSize: 120)),
        ]),
      ),
    );
  }
}
