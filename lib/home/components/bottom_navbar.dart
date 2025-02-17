import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotify/main.dart';

class BottomNavbar extends StatefulWidget {
  final Function(int index) onChanged;

  const BottomNavbar({super.key, required this.onChanged});

  static const fgUnselectedColor = Color(0xFFa4a4a4);
  static const fgSelectedColor = Colors.white;

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(iconTheme: IconThemeData(size: 35, color: Colors.white)),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Colors.transparent,
              MyApp.bgColor.withAlpha(10),
              MyApp.bgColor.withAlpha(150),
              MyApp.bgColor.withAlpha(160),
              MyApp.bgColor.withAlpha(215),
              MyApp.bgColor.withAlpha(240),
              MyApp.bgColor.withAlpha(250),
              MyApp.bgColor
            ],
                stops: [
              0.0,
              0.01,
              0.25,
              0.3,
              0.55,
              0.65,
              0.75,
              1.0
            ])),
        padding: EdgeInsets.only(bottom: 30, top: 45),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(3, (index) {
              final icon = [
                Icons.home_rounded,
                CupertinoIcons.search,
                Icons.library_music_rounded
              ][index];

              final label = ["Home", "Search", "Library"][index];

              return InkWell(
                onTap: () {
                  setState(() {
                    _currentIndex = index;
                  });
                  widget.onChanged(index);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(icon,
                          color: _currentIndex == index
                              ? BottomNavbar.fgSelectedColor
                              : BottomNavbar.fgUnselectedColor),
                      SizedBox(
                        height: 2,
                      ),
                      Text(label,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: _currentIndex == index
                                      ? BottomNavbar.fgSelectedColor
                                      : BottomNavbar.fgUnselectedColor)),
                    ],
                  ),
                ),
              );
            })),
      ),
    );
  }
}
