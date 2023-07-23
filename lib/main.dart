import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pm/Screens/HomeScreens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var selected = 0;
  var tabName = ["Home", "Skills", "Photos", "Videos"];
  var tabIcon = [
    Icons.home,
    Icons.construction,
    Icons.photo_library,
    Icons.video_call_rounded
  ];
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
              Container(
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
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: InkWell(
                                onTap: () {
                                  selected = index;
                                  setState(() {});
                                },
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                    color: selected == index
                                        ? Colors.grey.shade300
                                        : Colors.white,
                                    boxShadow: [
                                      selected == index
                                          ? BoxShadow(
                                              color: Colors.grey.shade400,
                                              offset: Offset(0, 5),
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
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: GetMaterialApp(
                debugShowCheckedModeBanner: false,
                home: HomeScreen(),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
