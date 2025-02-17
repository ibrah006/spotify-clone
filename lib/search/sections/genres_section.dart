import 'package:flutter/material.dart';
import 'package:spotify/search/components/genre_card.dart';
import 'package:spotify/search/helpers/genre_info.dart';

class GenresSection extends StatelessWidget {
  final List<GenreInfo> genres;
  final String title;

  GenresSection({super.key, required this.title, required this.genres});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 5),
          child: Text(
            title,
            style: textTheme.titleMedium,
          ),
        ),
        SizedBox(height: 10),
        GridView(
          padding: EdgeInsets.only(bottom: 20),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.65,
            mainAxisSpacing: 8,
            crossAxisSpacing: 6,
          ),
          children: List.generate(genres.length, (index) {
            final genreInfo = genres[index];

            return GenreCard(info: genreInfo);
          }),
        )
      ],
    );
  }
}
