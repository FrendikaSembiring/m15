import 'package:flutter/material.dart';

import '../pertemuan15_provider.dart';
import 'package:provider/provider.dart';

class ButtonImagePicker extends StatelessWidget {
  final String title;
  final bool isGalleryImage;
  const ButtonImagePicker(
      {Key? key, required this.isGalleryImage, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<Pertemuan15Provider>(context);
    return ElevatedButton(
        onPressed: () async {
          await prov.pickImage(isGalleryImage);
        },
        child: Text(title));
  }
}
