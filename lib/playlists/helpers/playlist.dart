import 'package:spotify/commons/collection/helpers/collection.dart';
import 'package:spotify/owner/helpers/owner.dart';

class Playlist extends Collection {
  Playlist({
    required super.coverImage,
    required super.title,
    required super.id,
    String? ownerId,
    String? findOwnerName,
    super.songs = const [],
    required Owner? owner,
  }) {
    creator = owner;

    if (ownerId != null) {
      throw UnimplementedError();
      // owner = Owner.fromId(ownerId);
    }
    if (findOwnerName != null) {
      throw UnimplementedError();
      // try {
      //   owner = Owner.fromName(findOwnerName);
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

  // .fromJson constructor for the Playlist class
  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      title: json['name'],
      id: json['id'],
      coverImage: json['images'] != null && json['images'].isNotEmpty
          ? json['images'][0]['url']
          : null, // Default to null if image is not available
      ownerId: json['owner'] != null ? json['owner']['id'] : null,
      findOwnerName:
          json['owner'] != null ? json['owner']['display_name'] : null,
      // Assuming songs field is an empty list by default
      owner: json['owner'] != null ? Owner.fromJson(json['owner']) : null,
    );
  }
}
