import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(const VideoApp());

/// Stateful widget to fetch and then display video content.
class VideoApp extends StatefulWidget {
  const VideoApp({Key? key}) : super(key: key);

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  void checkVideo() {
    // Implement your calls inside these conditions' bodies :
    if (_controller.value.position ==
        const Duration(seconds: 0, minutes: 0, hours: 0)) {
      //print('video Started');
    }

    if (_controller.value.position == _controller.value.duration) {
      if (contador == 1) {
        setState(() {
          floatingbuttonOff = true;
          flag_end_intro = true;
          contador = 2;
        });
      }
      if (contador == 2) {
        print('----------aaaaaaaaaaaaaaaaaaa--------');
        setState(() {
          flag_end_intro = true;
          contador = 3;
        });
      }
      if (contador == 3) {
        setState(() {});
        contador = 4;
      }

      print(contador);
      print(flag_end_intro);
    }
  }

  bool flag_end_intro = false;
  bool flag_right = false;
  bool flag_left = false;
  bool flag_front = false;
  bool floatingbuttonOff = false;
  int contador = 1;

  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset('assets/intro-video.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    _controller.addListener(checkVideo);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Room Game',
      home: Scaffold(
        backgroundColor: Color.fromRGBO(890, 300, 30, 70),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              if (!flag_end_intro)
                Container(
                  child: _controller.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        )
                      : Container(),
                ),
              if (flag_end_intro && !flag_left && !flag_front && !flag_right)
                Column(
                  children: [
                    Align(
                      child: SizedBox(
                        child: Image.asset('assets/basic.png'),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              flag_left = true;
                              flag_end_intro = false;
                              _controller =
                                  VideoPlayerController.asset('assets/left.mp4')
                                    ..initialize().then((_) {
                                      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
                                      setState(() {});
                                    });
                              _controller.addListener(checkVideo);
                              _controller.play();
                            },
                            child: Text('Left')),
                        ElevatedButton(
                            onPressed: () {
                              flag_front = true;
                              flag_end_intro = false;
                              _controller = VideoPlayerController.asset(
                                  'assets/front2.mp4')
                                ..initialize().then((_) {
                                  // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
                                  setState(() {});
                                });
                              _controller.addListener(checkVideo);
                              _controller.play();
                            },
                            child: Text('Center')),
                        ElevatedButton(
                            onPressed: () {
                              flag_right = true;
                              flag_end_intro = false;
                              _controller = VideoPlayerController.asset(
                                  'assets/right.mp4')
                                ..initialize().then((_) {
                                  // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
                                  setState(() {});
                                });
                              _controller.addListener(checkVideo);
                              _controller.play();
                            },
                            child: Text('Right')),
                      ],
                    ),
                  ],
                ),
              if (flag_end_intro && (flag_left || flag_front || flag_right))
                Column(
                  children: [
                    Align(
                      child: SizedBox(
                        child: Image.asset('assets/basic.png'),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              flag_left = true;
                              flag_end_intro = false;
                              _controller =
                                  VideoPlayerController.asset('assets/left.mp4')
                                    ..initialize().then((_) {
                                      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
                                      setState(() {});
                                    });
                              _controller.addListener(checkVideo);
                              _controller.play();
                            },
                            child: Text('Left')),
                        ElevatedButton(
                            onPressed: () {
                              flag_front = true;
                              flag_end_intro = false;
                              _controller = VideoPlayerController.asset(
                                  'assets/front2.mp4')
                                ..initialize().then((_) {
                                  // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
                                  setState(() {});
                                });
                              _controller.addListener(checkVideo);
                              _controller.play();
                            },
                            child: Text('Center')),
                        ElevatedButton(
                            onPressed: () {
                              flag_right = true;
                              flag_end_intro = false;
                              _controller = VideoPlayerController.asset(
                                  'assets/right.mp4')
                                ..initialize().then((_) {
                                  // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
                                  setState(() {});
                                });
                              _controller.addListener(checkVideo);
                              _controller.play();
                            },
                            child: Text('Right')),
                      ],
                    ),
                  ],
                ),
            ],
          ),
        ),
        floatingActionButton: !floatingbuttonOff
            ? FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
                child: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                ),
              )
            : null,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
