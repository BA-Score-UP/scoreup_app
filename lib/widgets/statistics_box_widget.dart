import 'package:flutter/material.dart';

class StatBox extends StatelessWidget {
  final String tile;
  final int quantity;
  final Color color;

  const StatBox({
    Key? key,
    required this.tile,
    required this.quantity,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 64,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(quantity.toString(), style: const TextStyle(fontSize: 20)),
          Text(tile, style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}