import 'package:flutter/material.dart';

import '../pertemuan15_provider.dart';
import 'package:provider/provider.dart';

class ButtonVideoPicker extends StatelessWidget {
  final String title;
  final bool isGalleryVideo;
  const ButtonVideoPicker(
      {Key? key, required this.isGalleryVideo, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<Pertemuan15Provider>(context);
    return ElevatedButton(
      onPressed: () async {
        await prov.pickVideo(isGalleryVideo);
      },
      child: Text(title),
    );
  }
}
