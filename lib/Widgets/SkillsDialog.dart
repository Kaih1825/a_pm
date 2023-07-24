import 'package:flutter/material.dart';

class SkillsDialog extends StatefulWidget {
  final tisSkillsList;
  final index;
  const SkillsDialog(
      {Key? key, required this.tisSkillsList, required this.index})
      : super(key: key);

  @override
  State<SkillsDialog> createState() => _SkillsDialogState();
}

class _SkillsDialogState extends State<SkillsDialog> {
  get list => widget.tisSkillsList;
  var index = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    index = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 200, vertical: 50),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      list[index]["Name"],
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: SelectableText(list[index]["Description"],
                          style: TextStyle(fontSize: 18)),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: double.infinity,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 35),
                      child: Image.network(
                        list[index]["Image"],
                        loadingBuilder: (context, child, loading) {
                          if (loading == null) {
                            return child;
                          }
                          return const CircularProgressIndicator();
                        },
                      ),
                    ),
                    Spacer(),
                    index == list.length - 1
                        ? Container()
                        : ElevatedButton(
                            onPressed: () {
                              index++;
                              setState(() {});
                            },
                            child: const Text("Next"))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
