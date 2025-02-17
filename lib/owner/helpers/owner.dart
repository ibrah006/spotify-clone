import 'package:spotify/commons/collection/helpers/creator.dart';

class Owner extends Creator {
  Owner({required super.name, required super.image, required super.id});

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
        name: json["display_name"], image: json["uri"], id: json["id"]);
  }

  factory Owner.fromId(String id) {
    return Owner(name: '', image: '', id: id);
  }
}
