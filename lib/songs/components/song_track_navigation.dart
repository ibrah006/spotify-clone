import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:spotify/commons/collection/providers/collection_provider.dart';
import 'package:spotify/commons/collection/providers/selected_song_provider.dart';
import 'package:spotify/commons/state/stream_handler.dart';
import 'package:spotify/extensions.dart';
import 'package:spotify/songs/helpers/player_states.dart';
import 'package:spotify/songs/helpers/song.dart';

class SongTrackNavigation extends StatefulWidget {
  const SongTrackNavigation({super.key});

  @override
  State<SongTrackNavigation> createState() => _SongTrackNavigationState();
}

class _SongTrackNavigationState extends State<SongTrackNavigation> {
  late Song selectedSong;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final collectionProvider = context.read<CollectionProvider>();
    final collection = collectionProvider.collection;

    final isPlaying = context.read<SelectedSongProvider>().playerState ==
        PlayerStates.playing;

    final previewEnded = context.read<SelectedSongProvider>().playerState ==
        PlayerStates.previewEnd;

    try {
      selectedSong;
    } catch (e) {
      print(
          "expected: selectedSong not initialized yet i.e., there is no song to be played, got: $e");

      // Simple display nothing when there is no song selected
      return SizedBox();
    }

    // print("song url: ${selectedSong.previewUrl}");

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
                    if ((selectedSong.previewUrl == null) || previewEnded)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (previewEnded)
                            InkWell(
                                onTap: playPauseAudio,
                                child: Icon(CupertinoIcons.refresh_thick)),
                          SizedBox(width: 10),
                          ElevatedButton(
                              onPressed: () {},
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("Open in Spotify"),
                                  SizedBox(width: 6),
                                  Icon(CupertinoIcons.link)
                                ],
                              )),
                        ],
                      )
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
                                      isPlaying
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
                    StreamBuilder<StreamHandler>(
                        stream: null,
                        builder: (context, snapshot) {
                          return Row(
                            children: [
                              Text(
                                  _audioPlayer.position.inMilliseconds
                                      .msToDisplayDuration(),
                                  style: textTheme.bodySmall),
                              SizedBox(width: 5),
                              Expanded(
                                child: LinearProgressIndicator(
                                  value: _audioPlayer.duration != null
                                      ? (_audioPlayer.position.inMilliseconds /
                                          selectedSong.durationRaw)
                                      : 0.0,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(selectedSong.duration,
                                  style: textTheme.bodySmall)
                            ],
                          );
                        }),
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
    bool resetUrl = false;
    switch (context.read<SelectedSongProvider>().playerState) {
      case PlayerStates.playing:
        () {
          _audioPlayer.pause();
          context.read<SelectedSongProvider>().playerState =
              PlayerStates.paused;
          setState(() {});
          return;
        };
      case PlayerStates.completed || PlayerStates.previewEnd:
        if (selectedSong.previewUrl != null) resetUrl = true;
      case PlayerStates.paused:
      case PlayerStates.idle:
    }

    // for all other cases i.e., completed, previewEnd, paused, idle
    if (selectedSong.previewUrl != null) {
      if (resetUrl) {
        _audioPlayer.setUrl(selectedSong.previewUrl!);
      }

      context.read<SelectedSongProvider>().playerState = PlayerStates.playing;
      _audioPlayer.play();
    }

    // if (_audioPlayer.playing) {
    //   _audioPlayer.pause();
    //   context.read<SelectedSongProvider>().playerState = PlayerStates.playing;
    // } else {
    //   if (selectedSong.previewUrl != null) {
    //     context.read<SelectedSongProvider>().playerState = PlayerStates.paused;
    //     _audioPlayer.play();
    //   }
    // }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _audioPlayer = AudioPlayer();

    try {
      selectedSong = context.read<SelectedSongProvider>().selectedSong ??
          context.read<CollectionProvider>().collection.songs.first;
    } catch (e) {
      print(
          "Expected: error in the second case of ternary statement. Not a CollectionPage (i.e., Album or Playlist) for selecting the first song, got: $e");
    }

    if (selectedSong.previewUrl != null) {
      _audioPlayer.setUrl(selectedSong.previewUrl!);
      context.read<SelectedSongProvider>().playerState = PlayerStates.idle;
    }

    // assign this stream listening to a variable and then unsubscribe from listening to this event when not needed
    _audioPlayer.positionStream.listen((duration) {
      if (_audioPlayer.duration != null) {
        if (_audioPlayer.position.inMilliseconds == selectedSong.durationRaw) {
          context.read<SelectedSongProvider>().playerState =
              PlayerStates.completed;
        } else if (_audioPlayer.duration!.inMilliseconds ==
            _audioPlayer.position.inMilliseconds) {
          // The audio has finished playing
          context.read<SelectedSongProvider>().playerState =
              PlayerStates.previewEnd;
        }
      } else if (_audioPlayer.playerState.playing) {
        context.read<SelectedSongProvider>().isPlaying = true;
        context.read<SelectedSongProvider>().playerState = PlayerStates.playing;
      }
      setState(() {});
    });

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
    if (_audioPlayer.playing) _audioPlayer.pause();
    _audioPlayer.dispose();
    super.dispose();
  }
}
