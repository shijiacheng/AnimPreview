import 'dart:io';

import 'package:anim_preview/utils/SpeedUtils.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../model/LottieModel.dart';
import 'generated/l10n.dart';

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
  bool _isInfoWidgetShow = false;
  LottieModel? _lottieModel;
  int _speedLevel = 2;

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
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return dropFileView();
  }

  Widget dropFileView() {
    return DropTarget(
        onDragDone: (DropDoneDetails details) {
          debugPrint("onDragDone details=${details.files}");
          // 获取到文件路径
          String? path = details.files.last.path;
          debugPrint("path=$path");
          if (path.isNotEmpty) {
            _isAnimPlaying = false;
            _currentSliderValue = 0;
            _controller.stop();
            _controller.reset();
            File file = File(path);
            lottieFile(file);
          }
        },
        child: _lottieFile == null ? emptyView() : lottiePreview());
  }

  Widget emptyView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        IconButton(
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform
                  .pickFiles(allowedExtensions: ["json"]);

              if (result != null) {
                _isAnimPlaying = false;
                _currentSliderValue = 0;
                _controller.stop();
                _controller.reset();
                File file = File(result.files.single.path!);
                lottieFile(file);
              } else {
                // User canceled the picker
              }
            },
            icon: const Icon(Icons.ads_click_rounded,
                size: 60, color: Colors.blue)),
        Text(S.of(context).openTips),
      ],
    );
  }

  Widget errorView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        IconButton(
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform
                  .pickFiles(allowedExtensions: ["json"]);

              if (result != null) {
                _isAnimPlaying = false;
                _currentSliderValue = 0;
                _controller.stop();
                _controller.reset();
                File file = File(result.files.single.path!);
                lottieFile(file);
              } else {
                // User canceled the picker
              }
            },
            icon: const Icon(Icons.ads_click_rounded,
                size: 60, color: Colors.blue)),
        Text(S.of(context).openLottieError)
      ],
    );
  }

  Widget lottiePreview() {
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
                    Icons.folder_open_rounded,
                    size: 30,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    FilePickerResult? result = await FilePicker.platform
                        .pickFiles(allowedExtensions: ["json"]);

                    if (result != null) {
                      _isAnimPlaying = false;
                      _currentSliderValue = 0;
                      _controller.stop();
                      _controller.reset();

                      File file = File(result.files.single.path!);
                      lottieFile(file);
                    } else {
                      // User canceled the picker
                    }
                  }),
              const Spacer(),
              IconButton(
                  icon: const Icon(
                    Icons.info_outline_rounded,
                    size: 28,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    _isInfoWidgetShow = !_isInfoWidgetShow;
                    setState(() {

                    });
                  }),
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
                _lottieModel = LottieModel();
                _lottieModel?.name = composition.name;
                _lottieModel?.duration = composition.duration;
                _lottieModel?.startFrame = composition.startFrame;
                _lottieModel?.endFrame = composition.endFrame;
                _lottieModel?.frameRate = composition.frameRate;
                _lottieModel?.width = composition.bounds.width;
                _lottieModel?.height = composition.bounds.height;
                setState(() {

                });
              },
              errorBuilder: (context, exception, stackTrace) {
                return errorView();
              },
            )),
            Visibility(child: infoWidget(_lottieModel), visible: _isInfoWidgetShow,)
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
                  tooltip: S.of(context).animReverse,
                  onPressed: () {
                    if (_isAnimPlaying) {
                      _controller.stop();
                    } else {
                      // _controller.reverseDuration = Duration(seconds: 4);
                      _controller.reverse();
                    }
                    _isAnimPlaying = !_isAnimPlaying;
                    setState(() {});
                  },
                  icon: Icon(Icons.skip_previous_rounded,
                      color: Colors.white, size: 32)),
              IconButton(
                tooltip: _isAnimPlaying ? S.of(context).animPause :  S.of(context).animPlay,
                  onPressed: () {
                    if (_isAnimPlaying) {
                      _controller.stop();
                    } else {

                      double seconds = _lottieModel == null ? 0 : _lottieModel!.duration!.inMilliseconds / SpeedUtils.getSpeed(_speedLevel + 1);
                      if(seconds > 0) {
                        _controller.duration = Duration(milliseconds:seconds.toInt());
                      }
                      _controller.forward();
                      _controller.repeat();
                    }
                    _isAnimPlaying = !_isAnimPlaying;
                    setState(() {});
                  },
                  icon: Icon(
                      _isAnimPlaying ? Icons.pause_circle : Icons.play_circle,
                      color: Colors.white,
                      size: 32)),
              IconButton(
                  tooltip: S.of(context).animStop,
                  onPressed: () {
                    _controller.stop();
                    _controller.reset();
                    _isAnimPlaying = false;
                    setState(() {});
                  },
                  icon: const Icon(Icons.stop_circle,
                      color: Colors.white, size: 32)),
              SizedBox(
                width: 400,
                child: Slider(
                  value: _currentSliderValue,
                  activeColor: Colors.white,
                  inactiveColor: Colors.indigo,
                  max: 100,
                  onChanged: (double value) {
                    setState(() {
                      _currentSliderValue = value;
                      _isAnimPlaying = false;
                      _controller.animateTo(_currentSliderValue / 100);
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

  Widget infoWidget(LottieModel? model) {
    return Container(
      padding: EdgeInsets.all(15),
      color: Colors.black87,
      width: 400,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment:CrossAxisAlignment.start,
        children: [
          Text(S.of(context).animSpeed, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 320,
                height: 100,
                child: Slider(
                  value: _speedLevel * 10,
                  divisions: 6,
                  activeColor: Colors.white,
                  inactiveColor: Colors.indigo,
                  max: 60,
                  onChanged: (double value) {
                    setState(() {
                      _speedLevel = value ~/ 10;

                    });
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 35),
                child:  Text(SpeedUtils.getSpeedString(_speedLevel + 1), style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),),
              )

            ],
          ),

          Text(S.of(context).animInfo, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),

          Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 120,
                        height: 25,
                        child: Text(S.of(context).animName, style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500))
                    ),
                    Text(model == null ? "" : model.name!, style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),)

                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 120,
                        height: 25,
                        child: Text(S.of(context).animDuration, style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500))
                    ),
                    Text(model == null ? "" : "${model.duration!.inSeconds} 秒", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),)

                  ],
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 120,
                        height: 25,
                        child: Text(S.of(context).frameCount, style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500))
                    ),
                    Text(model == null ? "" : (model.endFrame! - model.startFrame!).toInt().toString(), style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),)
                  ],
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 120,
                        height: 25,
                        child: Text(S.of(context).frameRate, style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500))
                    ),
                    Text(model == null ? "" : model.frameRate!.toInt().toString(), style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),)

                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 120,
                        height: 25,
                        child: Text(S.of(context).animBoundsSize, style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500))
                    ),
                    Text(model == null ? "" : "${model.width!} x ${model.height!}", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),)

                  ],
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
