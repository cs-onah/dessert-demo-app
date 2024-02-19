import 'package:demo_dessert_app/core/models/dessert.dart';
import 'package:flutter/material.dart';

class DessertCard extends StatelessWidget {
  final Dessert? dessert;
  const DessertCard({super.key, this.dessert});

  final double imageRadius = 20;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          margin: EdgeInsets.only(top: imageRadius),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
        ),
        CircleAvatar(radius: imageRadius,)
      ],
    );
  }
}

