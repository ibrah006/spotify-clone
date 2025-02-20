import 'package:flutter/material.dart';
import 'package:spotify/songs/helpers/player_states.dart';
import 'package:spotify/songs/helpers/song.dart';

// TODO: create a constructor: for accessing from collection (initial song

class SelectedSongProvider extends ChangeNotifier {
  Song? _selectedSong;

  set selectedSong(Song? song) {
    _selectedSong = song;
    playerState = PlayerStates.idle;
    isPlaying = false;
    notifyListeners();
  }

  Song? get selectedSong => _selectedSong;

  PlayerStates playerState;

  /// [selectFirstSong] will read the first song from CollectionProvider (if inside any of the CollectionPage i.e., Album or Playlist)
  SelectedSongProvider(
      {BuildContext? context,
      bool selectFirstSong = false,
      Song? song,
      required this.playerState}) {
    if (selectFirstSong == true && context == null) {
      throw "Cannot find the first song from outside of the CollectionPage. Please provide a song";
    }
  }

  @deprecated
  // This won't need to notify listeners as this is some variable that is mostly going to just be inside the SongTrackNavigation
  bool isPlaying = false;
}
