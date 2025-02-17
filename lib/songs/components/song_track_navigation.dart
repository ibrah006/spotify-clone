import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:spotify/commons/collection/state_controllers/collection_controller.dart';
import 'package:spotify/commons/collection/state_controllers/selected_song_controller.dart';

class SongTrackNavigation extends StatelessWidget {
  const SongTrackNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final CollectionController collectionController =
        Get.find<CollectionController>();

    final SelectedSongController songController =
        Get.find<SelectedSongController>();

    return Align(
      alignment: Alignment.bottomCenter,
      child: Obx(() {
        final selectedSong = songController.song.value;

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30)
              .copyWith(top: 15),
          // height: bottomAudioControllerHeight,
          decoration: BoxDecoration(color: Colors.black),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Obx(() {
                final collection = collectionController.collection.value;

                return ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(collection.coverImage, width: 60));
              }),
              SizedBox(width: 10),
              Expanded(
                flex: 1,
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
              SizedBox(width: 25),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("0:00", style: textTheme.bodySmall),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.skip_previous,
                                    color: Colors.grey.shade400,
                                    size: 31,
                                  )),
                              IconButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStatePropertyAll(Colors.white),
                                    foregroundColor:
                                        WidgetStatePropertyAll(Colors.black),
                                  ),
                                  icon:
                                      Icon(CupertinoIcons.play_fill, size: 20)),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.skip_next,
                                    color: Colors.grey.shade400,
                                    size: 31,
                                  )),
                            ],
                          ),
                        ),
                        Text(selectedSong.duration, style: textTheme.bodySmall)
                      ],
                    ),
                    SizedBox(height: 5),
                    LinearProgressIndicator(
                      value: .01,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
