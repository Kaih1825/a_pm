import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class VideoFullScreenDialog extends StatefulWidget {
  final mainVideoController;
  const VideoFullScreenDialog({Key? key, this.mainVideoController})
      : super(key: key);

  @override
  State<VideoFullScreenDialog> createState() => _VideoFullScreenDialogState();
}

class _VideoFullScreenDialogState extends State<VideoFullScreenDialog> {
  get mainVideoController => widget.mainVideoController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.black,
        child: Stack(
          children: [
            InkWell(
              onTapDown: (TapDownDetails) {
                mainVideoController!.setPlaybackSpeed(2.0);
              },
              onTapUp: (TapUpDetails) {
                mainVideoController!.setPlaybackSpeed(1.0);
              },
              onTap: () {
                if (mainVideoController!.value.isPlaying) {
                  mainVideoController!.pause();
                } else {
                  mainVideoController!.play();
                }
                setState(() {});
              },
              child: SizedBox(
                width: double.infinity,
                child: Center(
                  child: AspectRatio(
                      aspectRatio: mainVideoController!.value.aspectRatio,
                      child: VideoPlayer(mainVideoController!)),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 30,
                color: Colors.black.withAlpha(50),
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: DefaultTextStyle(
                    style: TextStyle(color: Colors.white),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            if (mainVideoController!.value.isPlaying) {
                              mainVideoController!.pause();
                            } else {
                              mainVideoController!.play();
                            }
                            setState(() {});
                          },
                          child: Icon(
                            mainVideoController!.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: Colors.white,
                          ),
                        ),
                        ValueListenableBuilder(
                          valueListenable: mainVideoController!,
                          builder: (BuildContext context,
                              VideoPlayerValue value, Widget? child) {
                            var gs = value.position
                                .toString()
                                .split(".")[0]
                                .split(":");
                            return Text("${gs[1]}:${gs[2]}");
                          },
                        ),
                        Text(
                            " / ${mainVideoController.value.position.toString().split(".")[0].split(":")[1]}:${mainVideoController.value.position.toString().split(".")[0].split(":")[1]}"),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            SystemChrome.setEnabledSystemUIMode(
                                SystemUiMode.manual,
                                overlays: SystemUiOverlay.values);
                          },
                          child: const Icon(Icons.fullscreen_exit,
                              color: Colors.white),
                        ),
                        InkWell(
                          onTap: () {
                            if (mainVideoController!.value.volume == 0) {
                              mainVideoController!.setVolume(1.0);
                            } else {
                              mainVideoController!.setVolume(0.0);
                            }
                            setState(() {});
                          },
                          child: Icon(
                            mainVideoController!.value.volume == 0.0
                                ? Icons.volume_off
                                : Icons.volume_up,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
