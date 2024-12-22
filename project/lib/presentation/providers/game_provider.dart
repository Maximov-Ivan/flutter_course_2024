import 'package:animated_flip_widget/animated_flip_widget.dart';
import 'package:flutter/material.dart';
import 'package:project/domain/models/tile.dart';
import 'package:project/domain/usecases/game_logic.dart';

class GameProvider with ChangeNotifier {
  final GameLogic _gameLogic = GameLogic();
  late int _numPairs;
  late List<Tile> tiles;
  late Tile lastTile;
  late bool wait;
  late int foundPairs;
  late int moves;
  late bool victory;

  GameProvider(int numPairs) {
    _numPairs = numPairs;
    _initGame();
  }

  void _initGame() {
    tiles = _gameLogic.generateTiles(_numPairs);
    lastTile = Tile(
      id: -1,
      icon: const IconData(0),
      controller: FlipController()
    );
    wait = false;
    foundPairs = 0;
    moves = 0;
    victory = false;
    notifyListeners();
  }

  void flipTile(Tile tile) async {
    if (!wait & !tile.isPaired & !tile.isFlipped) {
      tile.isFlipped = !tile.isFlipped;
      tile.controller.flip();
      notifyListeners();
      if (lastTile.isFlipped & !lastTile.isPaired & (tile.id != lastTile.id)) {
        moves++;
        if (_gameLogic.checkMatch(tile, lastTile)) {
          wait = true;
          await Future.delayed(const Duration(milliseconds: 500));
          wait = false;
          tile.isPaired = true;
          lastTile.isPaired = true;
          foundPairs++;
          if (foundPairs == _numPairs) {
            victory = true;
          }
        }
        else {
          wait = true;
          await Future.delayed(const Duration(seconds: 1));
          wait = false;
          tile.isFlipped = false;
          tile.controller.flip();
          lastTile.isFlipped = false;
          lastTile.controller.flip();
        }
      }
      lastTile = tile;
    }
    notifyListeners();
  }

  void resetGame() async {
    wait = true;
    for (final tile in tiles){
      if(tile.isFlipped) {
        tile.controller.flip();
        tile.controller.dispose();
      }
    }
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 500));
    tiles = _gameLogic.generateTiles(_numPairs);
    lastTile = Tile(
      id: -1,
      icon: const IconData(0),
      controller: FlipController()
    );
    wait = false;
    foundPairs = 0;
    moves = 0;
    victory = false;
    notifyListeners();
  }
}