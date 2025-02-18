import 'package:get/state_manager.dart';
import 'package:spotify/commons/collection/helpers/collection.dart';

class CollectionController extends GetxController {
  late Rx<Collection> collection;

  CollectionController(Collection collection) {
    // rethink about making this observable
    this.collection = collection.obs;
  }

  void reInitialize(Collection collection) {
    this.collection = collection.obs;
  }
}
