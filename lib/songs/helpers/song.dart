import 'package:spotify/extensions.dart';

class Song {
  String name, id;
  String? artist;
  String duration;
  String previewUrl;

  Song(
      {required this.name,
      required this.id,
      required this.artist,
      required this.duration,
      required this.previewUrl});

  factory Song.fromJson(Map<String, dynamic> json) {
    // track or episode if playlist
    json = (json['track'] ?? json["episode"]) ?? json;

    return Song(
      name: json['name'],
      id: json['id'],
      artist: json['artists'][0]['name'],
      duration: (json["duration_ms"] as int).msToDisplayDuration(),
      previewUrl: json['preview_url'],
    );
  }
}
