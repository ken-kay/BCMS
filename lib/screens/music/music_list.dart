import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bcms_app/screens/music/music_tile.dart';
import 'package:bcms_app/models/music.dart';

class MusicList extends StatefulWidget {
  @override
  _MusicListState createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
  @override
  Widget build(BuildContext context) {

    final musics=Provider.of<List<Music>>(context) ?? [];

    return ListView.builder(
        itemCount: musics.length,
        itemBuilder: (context,index){
          return MusicTile(music: musics[index]);
        },
    );
  }
}