import 'package:flutter/material.dart';
import 'package:pm/main.dart';

class BigPictureDialog extends StatefulWidget {
  final String url;
  const BigPictureDialog({Key? key, required this.url}) : super(key: key);

  @override
  State<BigPictureDialog> createState() => _BigPictureDialogState();
}

class _BigPictureDialogState extends State<BigPictureDialog> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showNavigationBar.value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: InteractiveViewer(
        child: Image.network(
          widget.url,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
