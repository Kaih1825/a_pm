import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pm/Screens/HomeScreens.dart';
import 'package:pm/Screens/Photos.dart';
import 'package:pm/Screens/Videos.dart';

import 'Screens/SkillsList.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

var selected = 0.obs;
var showNavigationBar = true.obs;

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  var tabName = ["Home", "Skills", "Photos", "Videos"];
  late Animation tween;
  late AnimationController animator;
  var tabIcon = [Icons.home, Icons.construction, Icons.photo_library, Icons.video_call_rounded];
  var pages = [const HomeScreen(), const SkillsList(), const Photos(), const Videos()];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animator = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    tween = IntTween(begin: 0, end: 255).animate(animator);
    animator.addListener(() {
      setState(() {});
    });
    animator.forward(from: 1);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: SafeArea(
          child: Row(
            children: [
              Obx(() => showNavigationBar.value
                  ? Container(
                      width: 150,
                      height: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 30),
                              child: Image.asset(
                                "res/logo.png",
                                color: Colors.black,
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: tabName.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Obx(() => Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        child: InkWell(
                                          onTap: () {
                                            selected.value = index;
                                            animator.forward(from: 0);
                                            setState(() {});
                                          },
                                          child: Container(
                                            width: 100,
                                            height: 100,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.grey.shade300),
                                              color: selected == index ? Color.fromARGB(tween.value, 232, 232, 232) : Colors.white,
                                              boxShadow: [
                                                selected == index
                                                    ? BoxShadow(
                                                        color: Color.fromARGB(tween.value, 129, 128, 128),
                                                        offset: Offset(tween.value / 255 * 5, tween.value / 255 * 5),
                                                        blurRadius: 4,
                                                      )
                                                    : BoxShadow()
                                              ],
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  tabIcon[index],
                                                  size: 50,
                                                ),
                                                Text(
                                                  tabName[index],
                                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ));
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : Container()),
              Expanded(
                  child: GetMaterialApp(
                debugShowCheckedModeBanner: false,
                home: Obx(() => pages[selected.value]),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
