import 'package:spotify/artists/helpers/artist.dart';
import 'package:spotify/commons/collection/helpers/collection.dart';

class Album extends Collection {
  Album({
    required super.coverImage,
    required super.title,
    required super.id,
    String? artistId,
    String? findArtistName,
    super.songs = const [],
    required Artist? artist,
  }) {
    creator = artist;

    if (artistId != null) {
      creator = Artist.fromId(artistId);
    }
    if (findArtistName != null) {
      try {
        creator = Artist.fromName(findArtistName);
      } catch (e) {}
    }
  }

  static final CollectionType collType = CollectionType.album;

  static Future<Album?> get(String albumId) async {
    return (await Collection.get(albumId, collType: collType)) as Album?;
  }

  // .fromJson constructor for the Album class
  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      title: json['name'],
      id: json['id'],
      coverImage: json['images'] != null && json['images'].isNotEmpty
          ? json['images'][0]['url']
          : null, // Default to null if image is not available
      artistId: json['artists'] != null && json['artists'].isNotEmpty
          ? json['artists'][0]['id']
          : null,
      findArtistName: json['artists'] != null && json['artists'].isNotEmpty
          ? json['artists'][0]['name']
          : null,
      // Assuming songs field is an empty list by default
      artist: json['artists'] != null && json['artists'].isNotEmpty
          ? Artist.fromJson(json['artists'][0])
          : null,
    );
  }
}
