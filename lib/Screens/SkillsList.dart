import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pm/Widgets/SkillsDialog.dart';

class SkillsList extends StatefulWidget {
  const SkillsList({Key? key}) : super(key: key);

  @override
  State<SkillsList> createState() => _SkillsListState();
}

class _SkillsListState extends State<SkillsList> {
  var types = List.empty(growable: true);
  var jsonArray = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    parseJson();
  }

  void parseJson() async {
    var jsonText =
        await DefaultAssetBundle.of(context).loadString("res/skills.json");
    jsonArray = jsonDecode(jsonText);
    for (var i in jsonArray) {
      var has = false;
      for (var j in types) {
        if (i["Type"] == j) {
          has = true;
        }
      }
      if (!has) {
        types.add(i["Type"]);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Skills List"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var type in types)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Container(
                        width: (MediaQuery.of(context).size.width - 150) / 2,
                        decoration: BoxDecoration(color: Colors.grey.shade400),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Text(
                            type,
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: jsonArray
                          .where((element) => element["Type"] == type)
                          .length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 6, crossAxisCount: 3),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            child: InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SkillsDialog(
                                      tisSkillsList: jsonArray
                                          .where((element) =>
                                              element["Type"] == type)
                                          .toList(),
                                      index: index,
                                    );
                                  },
                                );
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  children: [
                                    Text(
                                      jsonArray
                                          .where((element) =>
                                              element["Type"] == type)
                                          .toList()[index]["Name"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Spacer(),
                                    Icon(Icons.add)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
