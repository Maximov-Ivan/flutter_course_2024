import 'package:flutter/material.dart';
import 'package:animated_flip_widget/animated_flip_widget.dart';

class Tile {
  final int id;
  final IconData icon;
  final FlipController controller;
  bool isFlipped;
  bool isPaired;

  Tile({required this.id, required this.icon, required this.controller, this.isFlipped = false, this.isPaired = false});
}