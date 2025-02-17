import 'package:spotify/artists/helpers/artist.dart';
import 'package:spotify/commons/collection/helpers/collection.dart';

class Album extends Collection {
  Album(
      {required super.coverImage,
      required super.title,
      required super.id,
      String? artistId,
      String? findArtistName,
      super.songs = const [],
      required Artist? artist}) {
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
}
