import 'dart:math';
import 'package:animated_flip_widget/animated_flip_widget.dart';
import 'package:flutter/material.dart';
import 'package:project/domain/models/tile.dart';

class GameLogic {
  final Random random = Random();

  IconData getRandomIcon(){
    const String chars = '0123456789ABCDEF';
    int length = 3;
    String hex = '0xe';
    while(length-- > 0) {
      hex += chars[(random.nextInt(16)) | 0];
    }
    return IconData(int.parse(hex), fontFamily: 'MaterialIcons');
  }

  List<Tile> generateTiles(int numPairs) {
    final List<IconData> icons = List<IconData>.generate(
      numPairs,
      (int index) => getRandomIcon(),
      growable: false
    );

    final List<int> indexes = List<int>.generate(
      2 * numPairs,
      (int index) => index,
      growable: false
    );
    indexes.shuffle(random);

    final List<Tile> tiles = List<Tile>.generate(
      2 * numPairs,
      (int index) => Tile(
        id: indexes[index],
        icon: icons[index ~/ 2],
        controller: FlipController()
      ),
      growable: false
    );
    tiles.shuffle(random);

    return tiles;
  }

  bool checkMatch(Tile tile1, Tile tile2) {
    return tile1.icon == tile2.icon;
  }
}