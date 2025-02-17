import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:spotify/constants.dart';
import 'package:spotify/search/helpers/genre_info.dart';

class GenreCard extends StatelessWidget {
  final GenreInfo info;

  const GenreCard({super.key, required this.info});

  String get getImagePath => [IMAGE_PATH, info.imageName].join("/");

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: info.color,
      ),
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      padding: EdgeInsets.all(13),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Text(info.title,
                style: textTheme.titleMedium!
                    .copyWith(overflow: TextOverflow.clip)),
          ),
          Transform.rotate(
            angle: pi / 5,
            child: Transform.translate(
              offset: Offset(35, 10),
              child: Image.asset(
                getImagePath,
                width: 85,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
