import 'package:flutter/material.dart';

import 'package:flutter_beach/player_extract_page.dart';

class PlayerHistoryPage extends StatefulWidget {
  const PlayerHistoryPage({super.key});

  @override
  State<PlayerHistoryPage> createState() => _PlayerHistoryPageState();
}

class _PlayerHistoryPageState extends State<PlayerHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('履歴'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //const Text('data'),
              //const Text('data'),
              for (int i = 0; i < historyNumber; i++)
                Text(
                  '${tokorotenHistory[i + 1]}',
                  style: const TextStyle(fontSize: 36),
                ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      historyNumber = 0;
                      tokorotenHistory = [[]];
                    });
                  },
                  child: const Text('履歴削除', style: TextStyle(fontSize: 24),),),
            ],
          ),
        ),
      ),
    );
  }
}
