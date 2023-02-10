// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerScaffold {
  String videoURL;
  YoutubePlayerScaffold(this.videoURL);

  late YoutubePlayerController controller;

  void initState() {
    final videoID = YoutubePlayer.convertUrlToId(videoURL);

    controller = YoutubePlayerController(
      initialVideoId: videoID!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
      ),
    );
  }

  Container build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 25, bottom: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          YoutubePlayer(
            controller: controller,
            showVideoProgressIndicator: true,
          )
        ],
      ),
    );
  }
}
