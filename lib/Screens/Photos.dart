import 'dart:convert';

import 'package:flutter/material.dart';

class Photos extends StatefulWidget {
  const Photos({super.key});

  @override
  State<Photos> createState() => _PhotosState();
}

class _PhotosState extends State<Photos> {
  var jsonArray = [];
  var nowPage = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    parseJson();
  }

  void parseJson() async {
    jsonArray = jsonDecode(
        await DefaultAssetBundle.of(context).loadString("res/Images.json"));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Photos"),
      ),
      body: Container(
        height: double.infinity,
        child: Column(
          children: [
            Flexible(
              flex: 6,
              child: GridView.builder(
                itemCount: jsonArray.isEmpty ? 0 : 6,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1.19, crossAxisCount: 3),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      color: Colors.grey,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Image.network(
                                jsonArray[(nowPage - 1) * 6 + index]),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                color: Colors.black87,
                                height: 50,
                                width: 130,
                                child: DefaultTextStyle(
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: const [
                                          Text("Popularity: 230"),
                                          Text("Visit: 3500")
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Flexible(
              flex: 1,
              child: DefaultTextStyle(
                style: TextStyle(fontSize: 20, color: Colors.black),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      color: Colors.white,
                      child: InkWell(
                        onTap: () {
                          if (nowPage != 1) {
                            nowPage = 1;
                          }
                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: nowPage > 2 ? Text("1") : Container(),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: nowPage > 3
                            ? Center(
                                child: Text(
                                  "．．．",
                                ),
                              )
                            : Container(),
                      ),
                    ),
                    Container(
                      color: nowPage == 1 ? Colors.grey.shade400 : Colors.white,
                      child: InkWell(
                        onTap: () {
                          if (nowPage == 10) {
                            nowPage = 8;
                          } else if (nowPage != 1) {
                            nowPage--;
                          }
                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(nowPage == 1
                              ? "${nowPage}"
                              : nowPage == 10
                                  ? "8"
                                  : "${nowPage - 1}"),
                        ),
                      ),
                    ),
                    Container(
                      color: nowPage != 1 && nowPage != 10
                          ? Colors.grey.shade400
                          : Colors.white,
                      child: InkWell(
                        onTap: () {
                          if (nowPage == 10) {
                            nowPage = 9;
                          }
                          if (nowPage == 1) {
                            nowPage++;
                          }
                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(nowPage < 3
                              ? "2"
                              : nowPage == 10
                                  ? "9"
                                  : "${nowPage}"),
                        ),
                      ),
                    ),
                    Container(
                      color:
                          nowPage == 10 ? Colors.grey.shade400 : Colors.white,
                      child: InkWell(
                        onTap: () {
                          if (nowPage != 10) {
                            nowPage++;
                          }
                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(nowPage < 3
                              ? "3"
                              : nowPage < 9
                                  ? "${nowPage + 1}"
                                  : "10"),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: nowPage < 8
                            ? Center(
                                child: Text(
                                  "．．．",
                                ),
                              )
                            : Container(),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: InkWell(
                        onTap: () {
                          if (nowPage != 10) {
                            nowPage = 10;
                          }
                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: nowPage < 9 ? Text("10") : Container(),
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
    );
  }
}
