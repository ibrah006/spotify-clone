import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spotify/albums/helpers/album.dart';
import 'package:spotify/artists/helpers/artist.dart';
import 'package:spotify/commons/collection/helpers/creator.dart';
import 'package:spotify/owner/helpers/owner.dart';
import 'package:spotify/playlists/helpers/playlist.dart';
import 'package:spotify/secrets/access_token.dart';
import 'package:spotify/songs/helpers/song.dart';

enum CollectionType { playlist, album }

abstract class Collection {
  String coverImage, title, id;

  List<Song> songs;

  Creator? creator;

  Collection(
      {required this.coverImage,
      required this.title,
      required this.id,
      this.songs = const []});

  // static function

  /// [collectionId] is either playlist ID or album ID
  static Future<Collection?> get(String collectionId,
      {required CollectionType collType}) async {
    // collectionName ends up being "playlists" or "albums"
    final collectionName = "${collType.name}s";

    // Spotify API URL for getting an album
    final url =
        Uri.parse('https://api.spotify.com/v1/$collectionName/$collectionId');

    String accessToken =
        AccessToken.lastAccessToken ?? await AccessToken.getAccessToken();

    // Set the Authorization header with the access token
    final headers = {
      'Authorization': 'Bearer $accessToken',
    };

    // Make the GET request to the Spotify API
    http.Response response = await http.get(url, headers: headers);

    // The access token probably expired, so refresh it
    if (response.statusCode == 401) {
      accessToken = await AccessToken.getAccessToken();
      response = await http.get(url, headers: headers);
    }

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON data
      final data = jsonDecode(response.body);

      final albumName = data['name'];

      // Artist for an Album and Owner for a Playlist
      late final Map<String, dynamic>? artist;
      late final Map<String, dynamic>? owner;
      print("artist: ${data["artist"]}, owner: ${data['owner']}");
      try {
        artist = data['artists'][0];
      } catch (e) {
        artist = null;
        owner = data['owner'];
      }
      final imageUrl = data['images'][0]['url'];

      print('Album Name: $albumName');
      print('Album Artists: ${artist?["name"]}');
      print('Release Date: ${data['release_date']}');
      // You can access more fields depending on what data you need

      late final List rawSongs;
      if (collType == CollectionType.album) {
        // if collType == CollectionType.album -> artist is not null

        rawSongs = data['tracks']['items'];

        final songs = (rawSongs)
            .map((track) => Song.fromJson(track as Map<String, dynamic>))
            .toList();

        print("songs: ${songs}");

        return Album(
            coverImage: imageUrl,
            title: albumName,
            id: collectionId,
            songs: songs,

            /// if !isAlbum then it means owner is not null
            /// as either owner is null or artist is null
            artist: Artist.fromJson(artist!));
      } else {
        // if collType == CollectionType.playlist -> owner is not null

        // because playlists can either have tracks or episodes
        rawSongs = data['tracks']['items'];

        final songs = (rawSongs)
            .map((track) => Song.fromJson(track as Map<String, dynamic>))
            .toList();

        return Playlist(
            coverImage: imageUrl,
            title: albumName,
            id: collectionId,
            songs: songs,
            // songs: (data['tracks']['items'] as List)
            //     .map((track) => Song.fromJson(track as Map<String, dynamic>))
            //     .toList(),

            /// if !isAlbum then it means owner is not null
            /// as either owner is null or artist is null
            owner: Owner.fromJson(owner!));
      }
    } else {
      // If the server returns an error, print the error
      print('Failed to load album: ${response.statusCode}, ${response.body}');

      /// TODO: return some osrt of empty Album incase something goes wrong,
      /// the user would still see a screen that changes according to the not-retrievable album
      return null;
    }
  }
}
