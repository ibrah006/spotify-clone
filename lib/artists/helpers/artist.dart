import 'package:spotify/commons/collection/helpers/creator.dart';

class Artist extends Creator {
  static final List<Artist> artists = [
    Artist(
        name: 'Islam Sobhy',
        image:
            'https://i.scdn.co/image/ab67616d00001e024f02e437572ee768099e35ec',
        id: "ab67616d00001e024f02e437572ee"),
    Artist(
        name: 'عبدالرحمن مسعد',
        image:
            'https://i.scdn.co/image/ab67616100005174c7006cc923ad19acb434172e',
        id: "ab676161000051747c2e44e6e27c7fc4316eb7af"),
    Artist(
        name: 'Islam Sobhi',
        image:
            'https://i.scdn.co/image/ab676161000051747c2e44e6e27c7fc4316eb7af',
        id: "ab676161000051747c2e44e6e27c7fc4316eb7af"),
  ];

  factory Artist.fromId(String id) {
    return artists.firstWhere((artist) => artist.id == id);
  }

  factory Artist.fromName(String name) {
    return artists.firstWhere((artist) => artist.name == name);
  }

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      name: json['name'],
      image: json['uri'],
      id: json['id'],
    );
  }

  Artist({required super.name, required super.image, required super.id}) {}

  late String id;
}
