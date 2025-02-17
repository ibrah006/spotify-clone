import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LibraryCard extends StatelessWidget {
  final LinearGradient? linearGradient;
  final Color? color;
  final Icon icon;

  const LibraryCard(
      {super.key,
      this.linearGradient,
      required this.color,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return LayoutBuilder(builder: (context, constraints) {
      final maxWidth = constraints.maxWidth;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: maxWidth,
            decoration: BoxDecoration(gradient: linearGradient, color: color),
            child: Theme(
              data: Theme.of(context).copyWith(
                iconTheme: IconThemeData(size: 50, color: Colors.white),
              ),
              child: Center(
                child: icon,
              ),
            ),
          ),
          SizedBox(height: 13),
          Text("Liked Songs", style: textTheme.bodyLarge),
          SizedBox(height: 1),
          Row(
            children: [
              Transform.rotate(
                  angle: pi / 4,
                  child: Icon(CupertinoIcons.pin_fill,
                      size: 16, color: Color(0xFF25d663))),
              SizedBox(width: 5),
              Expanded(
                child: Text("Playlist: 30 songs",
                    style: textTheme.bodyLarge!.copyWith(
                        color: Colors.grey.shade400,
                        overflow: TextOverflow.ellipsis)),
              ),
            ],
          )
        ],
      );
    });
  }
}
