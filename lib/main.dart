import 'package:flutter/material.dart';
import 'package:spotify/albums/album_page.dart';
import 'package:spotify/playlists/playlist_page.dart';
import 'package:spotify/tab_manager/tab_manager.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final titleLarge = TextStyle(
    color: Colors.white,
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );

  static final navTitleStyle = titleLarge;

  static final titleMedium = TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.bold,
      overflow: TextOverflow.ellipsis);

  static final displayMedium = TextStyle(
      color: Colors.white,
      fontSize: 38,
      fontWeight: FontWeight.bold,
      overflow: TextOverflow.ellipsis);

  static const bgColor = Color(0xFF121212);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => TabManager(),
        "/album": (context) => AlbumPage(),
        "/playlist": (context) => PlaylistPage()
      },
      theme: ThemeData(
        progressIndicatorTheme: ProgressIndicatorThemeData(
            color: Colors.white, linearTrackColor: Colors.grey.shade700),
        iconTheme: IconThemeData(color: Colors.white),
        textTheme: textTheme.copyWith(
            displayMedium: displayMedium,
            titleLarge: titleLarge,
            titleMedium: titleMedium,
            titleSmall: textTheme.titleSmall!.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
            bodyLarge: textTheme.bodyLarge!
                .copyWith(color: Colors.white, fontSize: 15),
            bodyMedium: textTheme.bodyMedium!
                .copyWith(color: Colors.white, fontSize: 13),
            bodySmall:
                textTheme.bodySmall!.copyWith(color: Colors.grey.shade100)),
        appBarTheme: AppBarTheme(
            backgroundColor: bgColor,
            titleTextStyle: navTitleStyle,
            actionsIconTheme: IconThemeData(size: 33, color: Colors.white)),
        scaffoldBackgroundColor: bgColor,
        // Text button theme
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minimumSize: WidgetStatePropertyAll(Size.zero),
              padding: WidgetStatePropertyAll(EdgeInsets.zero),
              iconSize: WidgetStatePropertyAll(18),
              iconColor: WidgetStatePropertyAll(Colors.white),
              foregroundColor: WidgetStatePropertyAll(Colors.white),
              textStyle: WidgetStatePropertyAll(textTheme.titleMedium)),
        ),
      ),
    );
  }
}
// P
