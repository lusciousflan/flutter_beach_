import 'package:flutter/material.dart';
import 'package:flutter_beach/home_page.dart';
import 'package:flutter_beach/player_extract_page.dart';

class PlayerSwitchPage extends StatefulWidget {
  const PlayerSwitchPage({super.key});

  @override
  State<PlayerSwitchPage> createState() => _PlayerSwitchPageState();
}

class _PlayerSwitchPageState extends State<PlayerSwitchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('参加者切替'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(children: [
              //Text('Coming Soon...'),
              //Text(''),
              for (int i = 0; i < numberOfPlayer; i++) ...{
                SwitchListTile(
                  title: Text(
                    '${i + 1} :   ${playCount[i]} 回',
                    style: const TextStyle(fontSize: 36),
                  ),
                  //subtitle: Text('${playCount[i]}'),
                  value: isSwitch[i],
                  onChanged: (bool value) {
                    setState(() {
                      isSwitch[i] = value;
                      if(value == false) {
                        restingNumber++;
                      } else {
                        restingNumber--;
                      }
                    });
                  },
                  //secondary: const Icon(Icons.lightbulb_outline),
                ),
                const Divider(color: Colors.black)
              }
            ]),
          ),
        ));
  }
}
