import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottiePreviewPageUI extends StatefulWidget {
  const LottiePreviewPageUI({super.key});

  @override
  State<StatefulWidget> createState() {
    return LottiePreviewPageState();
  }
}

class LottiePreviewPageState extends State<LottiePreviewPageUI>
    with TickerProviderStateMixin {
  File? _lottieFile;
  double _currentSliderValue = 0;
  bool _isAnimPlaying = false;

  //lottie动画控制器
  late AnimationController _controller;

  void lottieFile(File value) {
    setState(() {
      _lottieFile = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.addListener(() {
      _currentSliderValue = _controller.value * 100;
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_lottieFile == null) {
      return emptyView();
    } else {
      return LottiePreview();
    }
  }

  Widget emptyView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        IconButton(
            onPressed: () async {
              FilePickerResult? result =
                  await FilePicker.platform.pickFiles();

              if (result != null) {
                File file = File(result.files.single.path!);
                lottieFile(file);
              } else {
                // User canceled the picker
              }
            },
            icon: const Icon(Icons.ads_click_rounded,
                size: 60, color: Colors.blue)),
        const Text("点击上传一个Lottie文件到此处预览")
      ],
    );
  }

  Widget LottiePreview() {
    return Column(
      children: [
        Container(
          height: 60,
          color: const Color(0xFF1565C0),
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            children: [
              IconButton(
                  icon: const Icon(
                    Icons.file_open_rounded,
                    size: 30,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles();

                    if (result != null) {
                      File file = File(result.files.single.path!);
                      lottieFile(file);
                    } else {
                      // User canceled the picker
                    }
                  }),
              const Spacer(),
            ],
          ),
        ),
        Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                child: Lottie.file(
              _lottieFile!,
              animate: false,
              controller: _controller,
              onLoaded: (composition) {
                _controller.duration = composition.duration;
              },
            ))
          ],
        )),
        Container(
          padding: const EdgeInsets.only(bottom: 10),
          color: Color(0xFF1565C0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              IconButton(
                  onPressed: () {
                    if (_isAnimPlaying) {
                      _controller.stop();
                    } else {
                      _controller.reset();
                      _controller.forward();
                      _controller.repeat();
                    }
                    _isAnimPlaying = !_isAnimPlaying;
                    setState(() {});
                  },
                  icon: Icon(
                      _isAnimPlaying ? Icons.pause_circle : Icons.play_circle,
                      color: Colors.white,
                      size: 30)),
              Container(
                width: 500,
                child: Slider(
                  value: _currentSliderValue,
                  activeColor: Colors.white,
                  inactiveColor: Colors.indigo,
                  max: 100,
                  onChanged: (double value) {
                    setState(() {
                      _currentSliderValue = value;
                    });
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
