import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/commons/collection/providers/collection_provider.dart';
import 'package:spotify/songs/helpers/song.dart';

class SelectedSongProvider extends ChangeNotifier {
  late Song selectedSong;

  /// [selectFirstSong] will read the first song from CollectionProvider (if inside any of the CollectionPage i.e., Album or Playlist)
  SelectedSongProvider(
      {BuildContext? context, bool selectFirstSong = false, Song? song}) {
    if ((!selectFirstSong && song == null)) {
      throw ArgumentError.notNull(
          "the values of args selectedFirstSong and song cannot be false and null at the same time.");
    } else if (song != null) {
      selectedSong = song;
    } else if (selectFirstSong) {
      if (context != null) {
        try {
          selectedSong =
              context.read<CollectionProvider>().collection.songs.first;
        } catch (e) {
          // we're not in the descendent of any of the CollectionPage (i.e., Album or Playlist)
          throw "Cannot find the first song from outside of the CollectionPage. Please provide a song";
        }
      } else {
        throw ArgumentError.notNull(
            "context arg must not be null when selectedFirstSong is true. Or just pass a song");
      }
    }
  }
}
