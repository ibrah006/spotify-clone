import 'package:spotify/commons/collection/helpers/collection.dart';
import 'package:spotify/owner/helpers/owner.dart';

class Playlist extends Collection {
  Playlist(
      {required super.coverImage,
      required super.title,
      required super.id,
      String? ownerId,
      String? findOwnerName,
      super.songs = const [],
      required Owner? owner}) {
    creator = owner;

    if (ownerId != null) {
      throw UnimplementedError();
      // owner = Owner.fromId(artistId);
    }
    if (findOwnerName != null) {
      throw UnimplementedError();
      // try {
      //   owner = Owner.fromName(findArtistName);
      // } catch (e) {}
    }
  }

  void reInitializeSelf(Playlist? playlist) {
    if (playlist == null) return;

    coverImage = playlist.coverImage;
    title = playlist.title;
    id = playlist.id;
    creator = playlist.creator;
    songs = playlist.songs;
  }

  // static fields
  static const CollectionType collType = CollectionType.playlist;

  // static functions

  static Future<Playlist?> get(String playListId) async {
    return (await Collection.get(playListId, collType: collType)) as Playlist?;
  }
}
