import 'package:flutter/material.dart';
import 'package:pm/Widgets/VideoFullScreenDialog.dart';
import 'package:video_player/video_player.dart';

class Videos extends StatefulWidget {
  const Videos({Key? key}) : super(key: key);

  @override
  State<Videos> createState() => _VideosState();
}

extension DurationToString on Duration {
  String getString() {
    var gs = toString().split(".")[0].split(":");
    return "${gs[1]}:${gs[2]}";
  }
}

class _VideosState extends State<Videos> {
  var inputController = TextEditingController();
  VideoPlayerController? mainVideoController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mainVideoController = VideoPlayerController.networkUrl(Uri.parse("http://10.0.2.2:8487/video/1"))
      ..initialize().then((value) {
        setState(() {});
      })
      ..play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Videos"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Flexible(
                      flex: 3,
                      child: mainVideoController == null
                          ? Container()
                          : AspectRatio(
                              aspectRatio: mainVideoController!.value.aspectRatio,
                              child: Stack(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    child: VideoPlayer(mainVideoController!),
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
                                                  mainVideoController!.value.isPlaying ? Icons.pause : Icons.play_arrow,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              ValueListenableBuilder(
                                                valueListenable: mainVideoController!,
                                                builder: (BuildContext context, VideoPlayerValue value, Widget? child) {
                                                  return Text(value.position.getString());
                                                },
                                              ),
                                              Text(" / ${mainVideoController!.value.duration.getString()}"),
                                              Spacer(),
                                              InkWell(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        return VideoFullScreenDialog(
                                                          mainVideoController: mainVideoController!,
                                                        );
                                                      });
                                                },
                                                child: const Icon(
                                                  Icons.fullscreen,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  if (mainVideoController!.value.volume == 0.0) {
                                                    mainVideoController!.setVolume(1.0);
                                                  } else {
                                                    mainVideoController!.setVolume(0.0);
                                                  }
                                                  setState(() {});
                                                },
                                                child: Icon(
                                                  mainVideoController!.value.volume == 0.0 ? Icons.volume_off : Icons.volume_up,
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
                    ),
                    Flexible(
                      flex: 1,
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            color: Colors.grey.shade400,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 13),
                              child: Text("Video Title"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: SizedBox(
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 8,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(color: Colors.grey.shade300)),
                                        height: 50,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          child: TextField(
                                            controller: inputController,
                                            decoration: const InputDecoration(
                                              hintStyle: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
                                              hintText: "Type a new comment here.",
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(color: Colors.blueGrey, borderRadius: BorderRadius.circular(5)),
                                      child: InkWell(
                                        onTap: () {},
                                        child: const Center(
                                            child: Text(
                                          "Publish",
                                          style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                                        )),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Column(
                children: [
                  Text("More Videos..."),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
