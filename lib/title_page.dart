import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_beach/home_page.dart';
import 'package:audioplayers/audioplayers.dart';

class TitlePage extends StatefulWidget {
  const TitlePage({super.key});

  @override
  State<TitlePage> createState() => _TitlePageState();
}

class _TitlePageState extends State<TitlePage> {
  final _audio = AudioCache();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        const Text(
          '本日の参加人数:',
          style: TextStyle(fontSize: 24),
        ),
        TextField(
          maxLength: 2,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          style: const TextStyle(fontSize: 36),
          onChanged: (text) {
            numberOfPlayer = int.parse(text);
            debugPrint('$numberOfPlayer');
          },
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    _audio.play('b.mp3');
                    return const HomePage();
                  },
                ),
              );
            },
            child: const Text('決定', style: TextStyle(fontSize: 36),), ),
      ]),
    );
  }
}
