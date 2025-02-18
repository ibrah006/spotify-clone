import 'package:get/state_manager.dart';
import 'package:spotify/songs/helpers/song.dart';

class SelectedSongController extends GetxController {
  late Rx<Song> song;

  SelectedSongController(Song song) {
    this.song = song.obs;
  }

  void reInitialize(Song song) {
    this.song = song.obs;
  }
}
