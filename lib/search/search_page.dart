import 'package:flutter/material.dart';
import 'package:spotify/search/helpers/genre_info.dart';
import 'package:spotify/search/sections/genres_section.dart';

class SearchPage extends StatefulWidget {
  SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List<GenreInfo> yourGenres = [
    GenreInfo(title: "Indie", imageName: "indie.png", color: Color(0xFFe13401)),
    GenreInfo(title: "R&B", imageName: "R&B.jpg", color: Color(0xFF7358fe)),
    GenreInfo(
        title: "Reggae", imageName: "reggae.png", color: Color(0xFF1f3264)),
    GenreInfo(title: "Rock", imageName: "rock.jpg", color: Color(0xFFe9125d)),
  ];

  List<GenreInfo> get allGenres => [
        GenreInfo(
            title: "Podcast",
            imageName: "podcast.jpg",
            color: Color(0xFFb85d08)),
        GenreInfo(
            title: "Concert",
            imageName: "concert.jpg",
            color: Color(0xFF158a08)),
        ...yourGenres,
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height: 310,
                child: GenresSection(
                    title: "Your Top Genres", genres: yourGenres)),
            SizedBox(
                // This height differs according to the number of rows of genres
                height: 500,
                child: GenresSection(title: "Browse all", genres: allGenres))
          ],
        ),
      ),
    );
  }
}
