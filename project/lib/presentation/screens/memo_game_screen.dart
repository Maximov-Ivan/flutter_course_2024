import 'package:animated_flip_widget/animated_flip_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project/presentation/providers/game_provider.dart';

class MemoGameScreen extends StatelessWidget {
  const MemoGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GameProvider(6),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Memo Game')
        ),
        body: Consumer<GameProvider>(
          builder: (context, gameProvider, child) => Column(
            children: [
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: gameProvider.tiles.length,
                  itemBuilder: (context, index) {
                    final tile = gameProvider.tiles[index];
                    return GestureDetector(
                      onTap: () => gameProvider.flipTile(tile),
                      child: AnimatedFlipWidget(
                        front: Card(child: Container()),
                        back: Card(child: Icon(tile.icon)),
                        controller: tile.controller,
                        clickable: false,
                        flipDuration: const Duration(milliseconds: 500),
                        flipDirection: FlipDirection.horizontal,
                      )
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Moves: ${gameProvider.moves}',
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.deepOrange,
                  ),
                ),
              ),
              if(!gameProvider.victory)
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextButton(
                    onPressed: () => gameProvider.resetGame(),
                    child: const Text(
                      'Reset',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
              if(gameProvider.victory)
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextButton(
                    onPressed: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text(
                          'Victory',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.deepOrange,
                          ),
                        ),
                        content: Text(
                          'You won in ${gameProvider.moves} moves!',
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.orange,
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => {
                              Navigator.pop(context, 'Play again'),
                              gameProvider.resetGame(),
                            },
                            child: const Text('Play again'),
                          ),
                          TextButton(
                            onPressed: () => {
                              Navigator.pop(context, 'Back'),

                            },
                            child: const Text('Back'),
                          ),
                        ],
                      ),
                    ),
                    child: const Text(
                      'Finish',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  )
                ),
            ],
          ),
        )
      ),
    );
  }
}