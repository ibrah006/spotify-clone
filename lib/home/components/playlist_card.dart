import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotify/playlists/helpers/playlist.dart';

class PlaylistCard extends StatefulWidget {
  final Playlist playlist;

  const PlaylistCard({super.key, required this.playlist});

  static const bgColor = Color(0xFF292929);

  @override
  State<PlaylistCard> createState() => _PlaylistCardState();
}

class _PlaylistCardState extends State<PlaylistCard> {
  void onPressed() async {
    if (widget.playlist.songs.isEmpty) {
      print("No songs in this album, so we're getting it from api");
      widget.playlist.reInitializeSelf(await Playlist.get(widget.playlist.id));
    }
    try {
      Navigator.pushNamed(context, "/album", arguments: widget.playlist);
    } catch (e) {
      // TODO: Show snack bar saying "Make sure you have internet connection"
      print("Error fetching album: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // final MediaQuery.of(context).size.width,

    return LayoutBuilder(builder: (context, constraints) {
      final parentWidth = constraints.maxWidth;

      return InkWell(
        onTap: onPressed,
        child: Row(
          children: [
            Ink(
              width: parentWidth / 3.5,
              height: double.maxFinite,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius:
                      BorderRadius.horizontal(left: Radius.circular(3)),
                  image: DecorationImage(
                      image: NetworkImage(widget.playlist.coverImage))),
            ),
            Expanded(
              child: Ink(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: double.maxFinite,
                  decoration: BoxDecoration(
                    color: PlaylistCard.bgColor,
                    borderRadius:
                        BorderRadius.horizontal(right: Radius.circular(3)),
                  ),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(widget.playlist.title,
                          style: textTheme.titleMedium))),
            ),
          ],
        ),
      );
    });
  }
}
