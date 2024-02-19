import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_dessert_app/core/constants/url_config.dart';
import 'package:demo_dessert_app/core/models/dessert.dart';
import 'package:flutter/material.dart';

class DessertCard extends StatelessWidget {
  final Dessert? dessert;
  const DessertCard({super.key, this.dessert});

  final double imageRadius = 60;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          margin: EdgeInsets.only(top: imageRadius / 2),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
            border: Border.all(color: Color(0xffF6F6F8), width: 2),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(top: imageRadius + 10),
              child: Text(
                dessert?.strMeal ?? "--",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                // textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        CircleAvatar(
          radius: imageRadius + 3,
          backgroundColor: Colors.grey[300],
          child: CircleAvatar(
            radius: imageRadius,
            backgroundImage: CachedNetworkImageProvider(
              dessert?.strMealThumb ?? UrlConfig.defaultDessertImage,
            ),
          ),
        )
      ],
    );
  }
}
