import 'package:spotify/albums/helpers/album.dart';
import 'package:spotify/artists/helpers/artist.dart';
import 'package:spotify/playlists/helpers/playlist.dart';
import 'package:spotify/songs/helpers/song.dart';

// This is not a database table
class Search {
  List<Song> songs = [];
  List<Artist> artists = [];
  List<Album> albums = [];
  List<Playlist> playlists = [];

  List<dynamic> get podcasts {
    throw UnimplementedError();
  }

  List<dynamic> get episodes {
    throw UnimplementedError();
  }
}
