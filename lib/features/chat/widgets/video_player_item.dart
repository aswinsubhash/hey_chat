// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;
  const VideoPlayerItem({
    Key? key,
    required this.videoUrl,
  }) : super(key: key);

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController videoPlayerController;
 // bool isPlay = false;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((value) {
        videoPlayerController.setVolume(1);
      });
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: videoPlayerController.value.aspectRatio,
      child: GestureDetector(
        onTap: () {
          setState(() {
            videoPlayerController.value.isPlaying ? videoPlayerController.pause() : videoPlayerController.play();
          });
        },
        child: Stack(
          children: [
            VideoPlayer(videoPlayerController),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
             videoPlayerController.value.isPlaying ? Icons.pause : Icons.play_arrow
                ),
              ),
            
          ],
        ),
      ),
    );
  }
}
