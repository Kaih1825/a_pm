import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
  var nowIndex = 1;
  var videos = List.empty();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    parseJson();
    mainVideoController = setController1(1);
    setState(() {});
  }

  void parseJson() async {
    var response = await http.get(Uri.parse("http://10.0.2.2:8487/videos"));
    videos = jsonDecode(response.body);
    for (var i = 0; i < videos.length; i++) {
      videos[i]["controller"] = setController(i);
    }
    setState(() {});
  }

  VideoPlayerController setController(index) {
    var con = VideoPlayerController.networkUrl(
        Uri.parse("http://10.0.2.2:8487/video/$index"))
      ..initialize().then((value) {
        setState(() {});
      });
    return con;
  }

  VideoPlayerController setController1(index) {
    var con = VideoPlayerController.networkUrl(
        Uri.parse("http://10.0.2.2:8487/video/$index"))
      ..initialize().then((value) {
        setState(() {});
      })
      ..play();
    return con;
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
              flex: 3,
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Flexible(
                      flex: 3,
                      child: mainVideoController == null
                          ? Container()
                          : AspectRatio(
                              aspectRatio:
                                  mainVideoController!.value.aspectRatio,
                              child: Stack(
                                children: [
                                  InkWell(
                                    onTapDown: (TapDownDetails) {
                                      mainVideoController!.setPlaybackSpeed(2);
                                    },
                                    onTapUp: (TapUpDetails) {
                                      mainVideoController!.setPlaybackSpeed(1);
                                    },
                                    onTap: () {
                                      if (mainVideoController!
                                          .value.isPlaying) {
                                        mainVideoController!.pause();
                                      } else {
                                        mainVideoController!.play();
                                      }
                                      setState(() {});
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      child: VideoPlayer(mainVideoController!),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      height: 30,
                                      color: Colors.black.withAlpha(50),
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: DefaultTextStyle(
                                          style: TextStyle(color: Colors.white),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  if (mainVideoController!
                                                      .value.isPlaying) {
                                                    mainVideoController!
                                                        .pause();
                                                  } else {
                                                    mainVideoController!.play();
                                                  }
                                                  setState(() {});
                                                },
                                                child: Icon(
                                                  mainVideoController!
                                                          .value.isPlaying
                                                      ? Icons.pause
                                                      : Icons.play_arrow,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              ValueListenableBuilder(
                                                valueListenable:
                                                    mainVideoController!,
                                                builder: (BuildContext context,
                                                    VideoPlayerValue value,
                                                    Widget? child) {
                                                  return Text(value.position
                                                      .getString());
                                                },
                                              ),
                                              Text(
                                                  " / ${mainVideoController!.value.duration.getString()}"),
                                              Spacer(),
                                              InkWell(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return VideoFullScreenDialog(
                                                          mainVideoController:
                                                              mainVideoController!,
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
                                                  if (mainVideoController!
                                                          .value.volume ==
                                                      0.0) {
                                                    mainVideoController!
                                                        .setVolume(1.0);
                                                  } else {
                                                    mainVideoController!
                                                        .setVolume(0.0);
                                                  }
                                                  setState(() {});
                                                },
                                                child: Icon(
                                                  mainVideoController!
                                                              .value.volume ==
                                                          0.0
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
                    ),
                    Flexible(
                      flex: 1,
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            color: Colors.grey.shade400,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 13),
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
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color: Colors.grey.shade300)),
                                        height: 50,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: TextField(
                                            controller: inputController,
                                            decoration: const InputDecoration(
                                              hintStyle: TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  color: Colors.grey),
                                              hintText:
                                                  "Type a new comment here.",
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
                                      decoration: BoxDecoration(
                                          color: Colors.blueGrey,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: InkWell(
                                        onTap: () {},
                                        child: const Center(
                                            child: Text(
                                          "Publish",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "More Videos...",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: videos.length,
                        itemBuilder: (BuildContext context, int index) {
                          return nowIndex == index
                              ? Container()
                              : Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: videos[index]["controller"] != null
                                      ? InkWell(
                                          onTap: () {
                                            nowIndex = index;
                                            mainVideoController =
                                                setController1(index);
                                            setState(() {});
                                          },
                                          child: AspectRatio(
                                              aspectRatio: (videos[index]
                                                          ["controller"]
                                                      as VideoPlayerController)
                                                  .value
                                                  .aspectRatio,
                                              child: Stack(
                                                children: [
                                                  VideoPlayer(videos[index]
                                                      ["controller"]),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .grey.shade800,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical: 5),
                                                          child: Text(
                                                            "${(videos[index]["controller"] as VideoPlayerController).value.duration.toString().split(":")[1].length == 2 && (videos[index]["controller"] as VideoPlayerController).value.duration.toString().split(":")[1][0] == "0" ? (videos[index]["controller"] as VideoPlayerController).value.duration.toString().split(":")[1][1] : (videos[index]["controller"] as VideoPlayerController).value.duration.toString().split(":")[1]}:${(videos[index]["controller"] as VideoPlayerController).value.duration.toString().split(":")[2].split(".")[0]}",
                                                            style: const TextStyle(
                                                                fontSize: 20,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )),
                                        )
                                      : Container(),
                                );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
