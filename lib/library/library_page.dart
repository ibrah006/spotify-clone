import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotify/library/components/library_card.dart';
import 'package:spotify/library/components/radio.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(17),
        child: Column(
          children: [
            // Category radio buttons
            Row(
              children: List.generate(3, (index) {
                return RadioButton(
                    label: ["Playlists", "Podcasts", "Albums"][index]);
              }),
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.arrow_up_arrow_down),
                      SizedBox(width: 8),
                      Text("Recents", style: textTheme.titleSmall)
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(CupertinoIcons.list_bullet),
                )
              ],
            ),
            SizedBox(height: 6),

            // PLaylists, Podcasts, and Albums section / cards
            Expanded(
              child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: .5,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  padding: EdgeInsets.zero,
                  children: [
                    LibraryCard(
                        color: null,
                        linearGradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFF4108e4), Color(0xFFb8eac6)]),
                        icon: Icon(CupertinoIcons.heart_fill))
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
