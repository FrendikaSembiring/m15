import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_project/pertemuan15/components/button_image_picker.dart';
import 'package:my_project/pertemuan15/components/button_video_picker.dart';
import 'package:my_project/pertemuan15/components/carousel_slider.dart';

import 'package:my_project/pertemuan15/pertemuan15_provider.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class Pertemuan15Screen extends StatefulWidget {
  const Pertemuan15Screen({super.key});

  @override
  State<Pertemuan15Screen> createState() => _Pertemuan15ScreenState();
}

class _Pertemuan15ScreenState extends State<Pertemuan15Screen> {
  List<XFile>? listImg;

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<Pertemuan15Provider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Praktek 15"),
        ),
        body: ListView(
          children: [
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Text(
                        "Video",
                        style: TextStyle(fontSize: 25),
                      )
                    ],
                  ),
                ),

                // Video Picker
                prov.isVideoLoaded && prov.video != null
                    ? Column(
                        children: [
                          Center(
                            // child: prov.videoPC != null &&
                            //         prov.videoPC!.value.isInitialized
                            child: prov.videoPC != null
                                ? AspectRatio(
                                    aspectRatio:
                                        prov.videoPC!.value.aspectRatio,
                                    child: VideoPlayer(prov.videoPC!),
                                  )
                                : Container(),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                prov.videoPC!.value.isPlaying
                                    ? prov.videoPC!.pause()
                                    : prov.videoPC!.play();
                              });
                            },
                            child: Icon(
                              prov.videoPC!.value.isPlaying
                                  ? Icons.abc
                                  : Icons.play_arrow,
                            ),
                          ),
                        ],
                      )
                    : Container(),

                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ButtonVideoPicker(
                          isGalleryVideo: true, title: "Open Video"),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(),
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Text(
                        "Image",
                        style: TextStyle(fontSize: 25),
                      )
                    ],
                  ),
                ),
                // Carousel Slider
                CarouselSliderWidget(), Divider(),
                // Image Picker
                prov.isImageLoaded == true
                    ? Image.network(prov.img!.path)
                    : Container(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const ButtonImagePicker(
                          isGalleryImage: true, title: "Open Gallery"),
                      TextButton(
                          onPressed: () async {
                            var pilihGambar = ImagePicker();
                            var hasil = await pilihGambar.pickMultiImage();

                            // ignore: unnecessary_null_comparison
                            if (hasil != null) {
                              setState(() {
                                prov.setListImg(hasil);
                              });
                            }
                          },
                          child: const Text("Multi Image")),
                      const ButtonImagePicker(
                          isGalleryImage: false, title: "Camera")
                    ],
                  ),
                ),
                listImg != null
                    ? Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SizedBox(
                          height: 300,
                          width: MediaQuery.of(context).size.width,
                          child: GridView.count(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 4,
                              children: listImg!.map((e) {
                                return Image.network(e.path);
                              }).toList()),
                        ),
                      )
                    : Container()
              ],
            )
          ],
        ));
  }
}
