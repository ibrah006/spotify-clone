import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:spotify/commons/collection/providers/collection_provider.dart';
import 'package:spotify/commons/collection/providers/selected_song_provider.dart';

class SongTrackNavigation extends StatefulWidget {
  const SongTrackNavigation({super.key});

  @override
  State<SongTrackNavigation> createState() => _SongTrackNavigationState();
}

class _SongTrackNavigationState extends State<SongTrackNavigation> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final collectionProvider = context.read<CollectionProvider>();
    final collection = collectionProvider.collection;
    final selectedSong = context.read<SelectedSongProvider>().selectedSong;

    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30)
              .copyWith(top: 15),
          // height: bottomAudioControllerHeight,
          decoration: BoxDecoration(color: Colors.black),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(collection.coverImage, width: 60)),
              SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(selectedSong.name,
                        style: textTheme.titleMedium!
                            .copyWith(fontWeight: FontWeight.w500)),
                    Text(selectedSong.artist ?? "Unknown",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodyMedium),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 5,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (selectedSong.previewUrl == null)
                      ElevatedButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Open in Spotify"),
                              SizedBox(width: 10),
                              Icon(CupertinoIcons.share)
                            ],
                          ))
                    else
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.skip_previous,
                                color: Colors.grey.shade400,
                                size: 31,
                              )),
                          SizedBox(width: 3),
                          isBuffering
                              ? CircularProgressIndicator()
                              : IconButton(
                                  onPressed: playPauseAudio,
                                  style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStatePropertyAll(Colors.white),
                                    foregroundColor:
                                        WidgetStatePropertyAll(Colors.black),
                                  ),
                                  icon: Icon(
                                      _audioPlayer.playing
                                          ? CupertinoIcons.pause_fill
                                          : CupertinoIcons.play_fill,
                                      size: 20)),
                          SizedBox(width: 3),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.skip_next,
                                color: Colors.grey.shade400,
                                size: 31,
                              )),
                        ],
                      ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text("0:00", style: textTheme.bodySmall),
                        SizedBox(width: 5),
                        Expanded(
                          child: LinearProgressIndicator(
                            value: bufferingProgress,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(selectedSong.duration, style: textTheme.bodySmall)
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  late AudioPlayer _audioPlayer;

  bool isBuffering = false;

  double bufferingProgress = 0.0;

  playPauseAudio() {
    if (_audioPlayer.playing) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _audioPlayer = AudioPlayer();

    // Listen for the playback state to determine buffering
    _audioPlayer.playerStateStream.listen((state) {
      // Check if buffering is happening based on ProcessingState
      if (state.processingState == ProcessingState.buffering) {
        setState(() {
          isBuffering = true;
        });
      } else if (state.processingState == ProcessingState.ready) {
        setState(() {
          isBuffering = false;
        });
      }

      // You can use bufferedPosition to track how much audio has been buffered
      if (state.processingState == ProcessingState.buffering) {
        double progress = _audioPlayer.bufferedPosition.inMilliseconds /
            _audioPlayer.duration!.inMilliseconds;
        setState(() {
          bufferingProgress = progress;
        });
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
