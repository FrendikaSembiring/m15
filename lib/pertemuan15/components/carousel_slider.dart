import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_project/pertemuan15/components/webview_widget.dart';
import 'package:my_project/pertemuan15/pertemuan15_provider.dart';
import 'package:provider/provider.dart';

class CarouselSliderWidget extends StatelessWidget {
  const CarouselSliderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<Pertemuan15Provider>(context);
    final List<XFile>? listImages = prov.listImg;
    return Container(
      padding: const EdgeInsets.only(top: 10),
      height: 300,
      child: CarouselSlider(
          options: CarouselOptions(height: 400.0),
          items: listImages!.asMap().entries.map((entry) {
            final index = entry.key + 1;
            final images = entry.value;

            return Builder(builder: (BuildContext context) {
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WebViewWidget(
                          url:
                              'https://old.mikroskil.ac.id/pengumuman/354$index')),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(images.path),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        'Berita $index',
                        style: const TextStyle(
                            fontSize: 16.0, color: Colors.purple),
                      ),
                    ),
                  ),
                ),
              );
            });
          }).toList()),
    );
  }
}
