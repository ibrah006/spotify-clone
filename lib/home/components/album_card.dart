import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotify/albums/helpers/album.dart';

class AlbumCard extends StatefulWidget {
  late Album album;

  AlbumCard({super.key, required this.album});

  static const fgColor = Color(0xFFc1c2c2);

  @override
  State<AlbumCard> createState() => _AlbumCardState();
}

class _AlbumCardState extends State<AlbumCard> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      // final parentHeight = constraints.maxHeight;
      final parentWidth = constraints.maxWidth;

      return Theme(
        data: ThemeData(
            iconButtonTheme: IconButtonThemeData(
                style: ButtonStyle(
                    iconSize: WidgetStatePropertyAll(29),
                    foregroundColor: WidgetStatePropertyAll(AlbumCard.fgColor),
                    minimumSize: WidgetStatePropertyAll(Size.zero),
                    padding: WidgetStatePropertyAll(EdgeInsets.all(15)),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap))),
        child: Padding(
          padding: EdgeInsets.only(top: 10, bottom: 35),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () async {
              if (widget.album.songs.isEmpty) {
                print("No songs in this album, so we're getting it from api");
                widget.album = (await Album.get(widget.album.id))!;
              }
              try {
                Navigator.pushNamed(context, "/album", arguments: widget.album);
              } catch (e) {
                // TODO: Show snack bar saying "Make sure you have internet connection"
                print("Error fetching album: $e");
              }
            },
            child: Ink(
              // margin: EdgeInsets.only(top: 10, bottom: 35),
              height: parentWidth / 1.87,
              padding: EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(colors: [
                  Color(0xFF4a4a49),
                  Color(0xFF4a4a49).withAlpha(90),
                  Color(0xFF4a4a49).withAlpha(40),
                  Color(0xFF4a4a49).withAlpha(40),
                  Color(0xFF4a4a49).withAlpha(40),
                ], stops: [
                  0.0,
                  0.125,
                  0.2,
                  0.65,
                  1
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.all(17),
                    height: parentWidth / 5,
                    width: parentWidth / 5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        image: NetworkImage(widget.album.coverImage),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  DefaultTextStyle(
                    style: TextStyle(color: AlbumCard.fgColor, fontSize: 17),
                    child: Container(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              CupertinoIcons.heart,
                            ),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.more_horiz),
                            onPressed: () {},
                          ),

                          // Spacing
                          Expanded(child: SizedBox()),

                          Text("2022 • 19 songs"),
                          SizedBox(width: 15),
                          IconButton(
                            style: ButtonStyle(
                                iconSize: WidgetStatePropertyAll(42),
                                minimumSize: WidgetStatePropertyAll(Size.zero),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                padding:
                                    WidgetStatePropertyAll(EdgeInsets.zero),
                                iconColor:
                                    WidgetStatePropertyAll(Colors.white)),
                            icon: Icon(CupertinoIcons.play_circle_fill),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
