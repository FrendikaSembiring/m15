import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

class Pertemuan15Provider extends ChangeNotifier {
  bool _isImageLoaded = false;
  bool get isImageLoaded => _isImageLoaded;

  set setIsImageLoaded(val) {
    _isImageLoaded = val;
    notifyListeners();
  }

  // ImagePicker
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _img;
  XFile? get img => _img;

  set setImg(XFile? value) {
    _img = value;
    notifyListeners();
  }

  List<XFile>? _listImg = [];
  List<XFile>? get listImg => _listImg;
  void setListImg(List<XFile>? value) {
    if (_listImg == null) {
      _listImg = value;
    } else {
      _listImg!.addAll(value!);
    }
    notifyListeners();
  }

  pickImage(bool isGalleryImage) async {
    try {
      var res = await _imagePicker.pickImage(
          source: isGalleryImage == true
              ? ImageSource.gallery
              : ImageSource.camera);
      if (res != null) {
        setImg = res;
        print(res);
        setIsImageLoaded = true;
      }
    } catch (e) {
      setIsImageLoaded = false;
      print(e.toString());
    }
  }

  // video
  XFile? _video;
  XFile? get video => _video;
  bool _isVideoLoaded = false;
  bool get isVideoLoaded => _isVideoLoaded;

  set setIsVideoLoaded(val) {
    _isVideoLoaded = val;
    notifyListeners();
  }

  set setVideo(XFile? value) {
    _video = value;
    notifyListeners();
  }

  VideoPlayerController? _controller;
  VideoPlayerController? get videoPC => _controller;

  pickVideo(bool isGalleryVideo) async {
    try {
      var res = await _imagePicker.pickVideo(
        source:
            isGalleryVideo == true ? ImageSource.gallery : ImageSource.camera,
      );
      if (res != null) {
        setVideo = res;
        setIsVideoLoaded = true;

        // ignore: deprecated_member_use
        _controller = VideoPlayerController.network(res.path)
          ..initialize().then((_) {});
      }
    } catch (e) {
      setIsVideoLoaded = false;
      print(e.toString());
    }
  }
}
