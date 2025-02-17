import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotify/albums/helpers/album.dart';
import 'package:spotify/playlists/helpers/playlist.dart';
import 'package:spotify/home/components/album_card.dart';
import 'package:spotify/home/components/playlist_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static final List<Playlist> playlists = [
    Playlist(
      title: 'Islam Sobhi',
      id: "4pvBTQ4kFoyAB4SoulTEaI",
      owner: null,
      coverImage:
          'https://i.scdn.co/image/ab67616d0000aa544e5d53a8929cfe651f1935fa',
    ),
    Playlist(
      title: 'Full Quran- Mishary',
      id: "3pRPSiVu1EOiZXC54ffR2e",
      owner: null,
      coverImage:
          'https://i.scdn.co/image/ab6765630000bdcf46650eb3b23ab9afe0031ec8',
    ),
    Playlist(
      title: 'HEREAFTER Anwar Al Awlaki',
      id: "0v7bzgEjffC38gDSg70dFL",
      owner: null,
      coverImage:
          'https://i.scdn.co/image/ab6765630000eeeecb660a9815225169ebc18079',
    ),
    Playlist(
      title: 'Abdul Rahman Mossad',
      id: "782q9HJpdjDM2HhNbIUu9a",
      owner: null,
      coverImage:
          'https://i.scdn.co/image/ab67616d0000aa546ddd6e8760bdf6bd47b0af93',
    ),
    Playlist(
      title: 'Ibrahim Idriss',
      id: "6jf5C5cbCE5wirF0dRwCcr",
      owner: null,
      coverImage:
          'https://image-cdn-fa.spotifycdn.com/image/ab67706c0000d72c21948c8fde50e080e3fe0bfd',
    ),
    Playlist(
      title: 'Quran Sudais',
      id: "3VA7vrIbAgnFSwzhBLrX40",
      owner: null,
      coverImage:
          'https://i.scdn.co/image/ab6765630000eeee8c7ea3e938d34053324fb9bb',
    ),
  ];

  static final List<Album> albums = [
    Album(
      id: "2acSXrZhyv0h9DK1ycFhvH",
      title: 'مقتطفات قرانية',
      findArtistName: 'Islam Sobhi',
      artist: null,
      coverImage:
          'https://i.scdn.co/image/ab67616d00001e026150fd0e22e561b133020cf8',
    ),
    Album(
      id: "0no7R1TpuA1ykKVppOg1dl",
      title: 'The Holy Quran',
      findArtistName: 'El Sheikh Abu Bakr Al Shatri',
      artist: null,
      coverImage:
          'https://i.scdn.co/image/ab67616d00001e0249cbb22e43821a79de41c9b6',
    ),
    Album(
      id: "2Yv8ZjQMeQTp2Ee8tOvP3i",
      title: 'جزء عم كاملا',
      findArtistName: 'Islam Sobhi',
      artist: null,
      coverImage:
          'https://i.scdn.co/image/ab67616d00001e024e5d53a8929cfe651f1935fa',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // final screenSize = MediaQuery.of(context).size;

    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: GridView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3.5,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
            children: List.generate(playlists.length,
                (index) => PlaylistCard(playlist: playlists[index])),
          ),
        ),

        // Artists Cards
        ...List.generate(albums.length, (index) {
          return AlbumCard(album: albums[index]);
        }),

        SizedBox(
          height: 85,
        )
      ],
    );
  }
}
