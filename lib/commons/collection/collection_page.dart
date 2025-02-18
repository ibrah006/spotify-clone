import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:spotify/albums/helpers/album.dart';
import 'package:spotify/commons/collection/helpers/collection.dart';
import 'package:spotify/commons/collection/state_controllers/collection_controller.dart';
import 'package:spotify/commons/collection/state_controllers/selected_song_controller.dart';
import 'package:spotify/playlists/helpers/playlist.dart';
import 'package:spotify/songs/components/song_track_navigation.dart';
import 'package:spotify/songs/helpers/song.dart';
import 'package:spotify/table/custom_table.dart';
import 'package:spotify/table/table_column.dart';

abstract class CollectionPage extends StatefulWidget {
  late final String title;

  CollectionPage({super.key});

  static const collectionCoverColor = Color(0xFF102048);

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  // late Collection collection;

  static const bottomAudioControllerHeight = 105.0;

  // late Song selectedSong;

  late final CollectionController collectionController;
  late final SelectedSongController selectedSongController;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    setLazyPuts();

    final collection = collectionController.collection.value;

    return Scaffold(
        body: Stack(
      // alignment: Alignment.bottomCenter,
      children: [
        SingleChildScrollView(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          CollectionPage.collectionCoverColor,
                          CollectionPage.collectionCoverColor.withAlpha(50)
                        ],
                        stops: [
                          .75,
                          1
                        ]),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20)
                      .copyWith(bottom: 120),
                  child: SafeArea(
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Album cover
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              width: 150,
                              collection.coverImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 16),
                          // Album title and artist
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.title,
                                  style: textTheme.bodyLarge!
                                      .copyWith(color: Colors.white),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  collection.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: textTheme.displayMedium,
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    if (collection.creator?.image != null) ...[
                                      // Artist image
                                      ClipOval(
                                          child: Image.network(
                                              collection.coverImage,
                                              width: 26)),
                                      SizedBox(width: 5),
                                    ],
                                    Expanded(
                                      child: Text(
                                        collection.creator?.name ?? "Unknown",
                                        style: textTheme.titleSmall!.copyWith(
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ]),
                  )),

              // Body content
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.only(
                    top: 265, bottom: bottomAudioControllerHeight),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF121212).withAlpha(75), Color(0xFF121212)],
                )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(CupertinoIcons.play_fill,
                                color: Colors.black, size: 26),
                            style: ButtonStyle(
                                padding:
                                    WidgetStatePropertyAll(EdgeInsets.all(15)),
                                backgroundColor:
                                    WidgetStatePropertyAll(Color(0xFF1ed760)))),
                        SizedBox(width: 12),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              CupertinoIcons.add_circled,
                              size: 35,
                              color: Colors.grey.shade400,
                            )),
                        SizedBox(width: 2),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.more_horiz,
                              size: 35,
                              color: Colors.grey.shade400,
                            )),
                        Expanded(child: SizedBox()),

                        // List mode toggle
                        InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.all(6).copyWith(right: 0),
                            child: Row(
                              children: [
                                Text('List'),
                                SizedBox(width: 10),
                                Icon(CupertinoIcons.list_bullet)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 30),

                    // Songs List
                    CustomTable(
                        columns: [
                          TableColumn(child: null, label: "#", columnFlex: 1),
                          TableColumn(
                              child: null, label: "Name", columnFlex: 5),
                          TableColumn(
                              child: Icon(CupertinoIcons.time), columnFlex: 1)
                        ],
                        rows: List.generate(collection.songs.length, (index) {
                          final Song song = collection.songs[index];

                          return TableRow(children: [
                            Text((index + 1).toString(),
                                style: textTheme.titleMedium!.copyWith(
                                    color: Colors.grey.shade400,
                                    fontWeight: FontWeight.w500)),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(song.name, style: textTheme.titleMedium),
                                  Text(song.artist ?? "Unknown",
                                      style: textTheme.titleSmall!.copyWith(
                                          color: Colors.grey.shade400,
                                          fontWeight: FontWeight.w500))
                                ],
                              ),
                            ),
                            Text(song.duration.toString(),
                                style: textTheme.bodyLarge!
                                    .copyWith(color: Colors.grey.shade400)),
                          ]);
                        }))
                  ],
                ),
              ),
            ],
          ),
        ),

        // Bottom audio player controller
        SongTrackNavigation()
      ],
    ));
  }

  void setLazyPuts() {
    late final Collection collection;

    try {
      // if the argument passed is an album then, pull the arg as an Album  -Album page
      collection = ModalRoute.of(context)!.settings.arguments as Album;
    } on TypeError {
      // else if the argument passed is an playlist then, pull the arg as an Playlist - Playlist page
      collection = ModalRoute.of(context)!.settings.arguments as Playlist;
    }

    try {
      if (collection.id ==
          Get.find<CollectionController>().collection.value.id) {
        collectionController = CollectionController(collection);
        selectedSongController = Get.find<SelectedSongController>();
        return;
      }
    } catch (e) {
      // Error caused due to getting collection from Get as we never set it
      print(
          "Error caused due to getting collection from Get as we never set it, actual: $e");
    }

    print("collection and selected song need re initialization");

    // Availability of collection provider in context
    setLazyPutCollection(collection);

    // initially we want the selected song to be the first song
    // Availability of selected song provider in context
    setLazyPutSelectedSong(isFirstSongSelected: true);
  }

  /// Put the CollectionController in the Get.lazyPut - making it available only in this screen
  void setLazyPutCollection(Collection collection) {
    try {
      print(
          "collection (arg): ${collection.id} ${collection.songs.first.name}, from get ${Get.find<CollectionController>().collection.value.id} ${Get.find<CollectionController>().collection.value.songs.first.name}");
    } catch (e) {
      // Error caused due to getting collection from Get as we never set it
      print(
          "Error caused due to getting collection from Get as we never set it, actual: $e");
    }
    try {
      collectionController = CollectionController(collection);
    } catch (e) {
      // on Late Initialization Error. field has not been initialized
      print("Expected Late initialization Error, got: $e");
      collectionController.reInitialize(collection);
    }

    Get.lazyPut<CollectionController>(() => collectionController);
  }

  /// Subscribe to the collection's songs change to update the selected song
  void setLazyPutSelectedSong(
      {bool isFirstSongSelected = false, String? songId, int? songIndex}) {
    if (!isFirstSongSelected && songId == null && songIndex == null) {
      throw ArgumentError.notNull(
          "isFirstSongSelected = false, songId = null, songIndex = null. All these parameters cannot be null/false at the same time. One of these parameters need to be fulfilled");
    }

    late final Song selectedSong;

    final Collection collection = collectionController.collection.value;

    if (isFirstSongSelected) {
      selectedSong = collection.songs.first;
    } else {
      if (songId != null) {
        selectedSong = collection.songs.firstWhere((song) => song.id == songId);
      } else if (songIndex != null) {
        selectedSong = collection.songs
            .firstWhere((song) => collection.songs.indexOf(song) == songIndex);
      }
    }

    try {
      selectedSongController = SelectedSongController(selectedSong);
    } catch (e) {
      // on Late Initialization Error. field has not been initialized
      selectedSongController.reInitialize(selectedSong);
    }
    Get.lazyPut<SelectedSongController>(() => selectedSongController);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    print('didChangeDependencies');

    // Using Getx to set "Lazy puts" for collection and selected song for...
    // their usage from this widget custom child components
    setLazyPuts();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    collectionController.dispose();
    try {
      selectedSongController.dispose();
    } catch (e) {
      // Error occurred when disposing selectedSongController
      print("to be debugged, Error: $e");
    }
  }
}
