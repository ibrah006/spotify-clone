import 'package:spotify/albums/helpers/album.dart';
import 'package:spotify/artists/helpers/artist.dart';
import 'package:spotify/playlists/helpers/playlist.dart';
import 'package:spotify/search/helpers/search.dart';
import 'package:spotify/secrets/access_token.dart';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:spotify/songs/helpers/song.dart';

class SearchProvider extends ChangeNotifier {
  final TextEditingController _searchController = TextEditingController();

  TextEditingController get controller => _searchController;

  String get query => _searchController.text.trim();

  Search details = Search();

  Future<Map<String, dynamic>> search(BuildContext context) async {
    if (query.isEmpty) {
      throw Exception('No search query provided');
    }

    String accessToken =
        AccessToken.lastAccessToken ?? await AccessToken.getAccessToken();

    final url = Uri.parse(
        'https://api.spotify.com/v1/search?q=$query&type=track,artist,album,playlist,show,episode');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      details.songs = (data['tracks']['items'] as List)
          .map((songRaw) => Song.fromJson(songRaw)) as List<Song>;
      details.artists = (data['artists']['items'] as List)
          .map((artistRaw) => Artist.fromJson(artistRaw))
          .toList();

      details.albums = (data['albums']['items'] as List)
          .map((albumRaw) => Album.fromJson(albumRaw))
          .toList();

      details.playlists = (data['playlists']['items'] as List)
          .map((playlistRaw) => Playlist.fromJson(playlistRaw))
          .toList();
      // details.podcasts = data['shows']['items'];
      // details.episodes = data['episodes']['items'];

      // Example: Print out the results
      print('Songs: ${details.songs}');
      print('Artists: ${details.artists}');
      print('Albums: ${details.albums}');
      print('Playlists: ${details.playlists}');

      return data;
    } else {
      throw Exception('Failed to search data');
    }
  }
}
