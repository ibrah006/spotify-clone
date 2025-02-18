import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/albums/helpers/album.dart';
import 'package:spotify/commons/collection/helpers/collection.dart';
import 'package:spotify/commons/collection/providers/collection_provider.dart';
import 'package:spotify/commons/collection/providers/selected_song_provider.dart';
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

  late final CollectionProvider collectionProvider;
  late final SelectedSongProvider selectedSongProvider;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
        body: MultiProvider(
      providers: [
        Provider<CollectionProvider>(create: (_) => collectionProvider),
        ChangeNotifierProvider<SelectedSongProvider>(
            create: (_) => selectedSongProvider),
      ],
      builder: (context, child) {
        final collection = collectionProvider.collection;

        return Stack(
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
                      padding:
                          EdgeInsets.symmetric(vertical: 30, horizontal: 20)
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
                                        if (collection.creator?.image !=
                                            null) ...[
                                          // Artist image
                                          ClipOval(
                                              child: Image.network(
                                                  collection.coverImage,
                                                  width: 26)),
                                          SizedBox(width: 5),
                                        ],
                                        Expanded(
                                          child: Text(
                                            collection.creator?.name ??
                                                "Unknown",
                                            style: textTheme.titleSmall!
                                                .copyWith(
                                                    overflow:
                                                        TextOverflow.ellipsis),
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
                      colors: [
                        Color(0xFF121212).withAlpha(75),
                        Color(0xFF121212)
                      ],
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
                                    padding: WidgetStatePropertyAll(
                                        EdgeInsets.all(15)),
                                    backgroundColor: WidgetStatePropertyAll(
                                        Color(0xFF1ed760)))),
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
                              TableColumn(
                                  child: null, label: "#", columnFlex: 1),
                              TableColumn(
                                  child: null, label: "Name", columnFlex: 5),
                              TableColumn(
                                  child: Icon(CupertinoIcons.time),
                                  columnFlex: 1)
                            ],
                            rows:
                                List.generate(collection.songs.length, (index) {
                              final Song song = collection.songs[index];

                              return TableRow(children: [
                                Text((index + 1).toString(),
                                    style: textTheme.titleMedium!.copyWith(
                                        color: Colors.grey.shade400,
                                        fontWeight: FontWeight.w500)),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(song.name,
                                          style: textTheme.titleMedium),
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
        );
      },
    ));
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    late final Collection collection;
    try {
      // if the argument passed is an album then, pull the arg as an Album  -Album page
      collection = ModalRoute.of(context)!.settings.arguments as Album;
    } on TypeError {
      // else if the argument passed is an playlist then, pull the arg as an Playlist - Playlist page
      collection = ModalRoute.of(context)!.settings.arguments as Playlist;
    }

    // initialize collectionProvider
    collectionProvider = CollectionProvider(collection);

    // initialize selectedSongProvider
    selectedSongProvider = SelectedSongProvider(song: collection.songs.first);
  }
}
