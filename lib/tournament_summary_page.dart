import 'package:flutter/material.dart';
import 'package:flutter_beach/tournament_current_page.dart';
import 'package:flutter_beach/tournament_result_page.dart';
import 'package:audioplayers/audioplayers.dart';

List<List<int>> matchList = List.generate(6, (index) => [4, 4]);
List<List<int>> matchResult = List.generate(6, (index) => [0, 0]);
int matchNumber = 1;

final _audio = AudioCache();

class TournamentSummaryPage extends StatefulWidget {
  const TournamentSummaryPage({super.key});

  @override
  State<TournamentSummaryPage> createState() => _TournamentSummaryPageState();
}

class _TournamentSummaryPageState extends State<TournamentSummaryPage> {
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
            const Spacer(),
            const Spacer(),
            //const Text('data2'),
            for(int i = 0; i < 6; i++) ...{
              const Spacer(),
              Row(
                children: [
                  TextButton(
                    onPressed: (){
                      _audio.play('b.mp3');
                      debugPrint('${i+1}');
                      debugPrint('${matchList[i]}');
                      matchNumber = i+1;
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const TournamentCurrentPage();
                          },
                        ),
                      );
                    }, 
                    child: Text('${i+1}', style: const TextStyle(fontSize: 48),)
                  ),
                  const Spacer(),
                  if(matchList[i][0] != 4) ...{ 
                    Text(
                      '${teams[matchList[i][0]]}', 
                      style: const TextStyle(fontSize: 60, color: Colors.blue),
                    ),
                    Text(
                      '(${matchResult[i][0]})',
                      style: const TextStyle(fontSize: 48, color: Colors.black54)
                      ),
                  } else const Text(' '),
                  const Spacer(),
                  const Text('-', style:TextStyle(fontSize: 36)),
                  const Spacer(),
                  if(matchList[i][1] != 4) ...{ 
                      Text(
                        '${teams[matchList[i][1]]}',
                        style: const TextStyle(fontSize: 60, color: Colors.blue),
                      ),
                      Text(
                      '(${matchResult[i][1]})',
                      style: const TextStyle(fontSize: 48, color: Colors.black54),
                      ),
                  } else const Text(' '),
                  const Spacer(),
                ],
              ),
            },
            const Spacer(),
            ElevatedButton(
              onPressed: (){
                resultWarp();
                _audio.play('c.mp3');
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const TournamentResultPage();
                    },
                  ),
                );
              }, 
              child: const Text('結果', style: TextStyle(fontSize: 36),)
            ),
        ],
        ),
        ));
  }
}