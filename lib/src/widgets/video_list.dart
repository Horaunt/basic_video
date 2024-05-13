import 'package:flutter/material.dart';
import '../models/video_info.dart';
import 'video_dialog.dart';
import 'video_list_tile.dart';

class VideoList extends StatelessWidget {
  final Iterable<VideoInfo> videos;
  final void Function(VideoInfo) onVideoAdded;
  final void Function(VideoInfo, int) onVideoEdited;

  const VideoList({
    Key? key = const Key('video_list'), // Provide a non-null default value
    required this.videos,
    required this.onVideoAdded,
    required this.onVideoEdited,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(constraints.maxWidth, 32),
            child: Material(
              color: Colors.grey[800],
              child: Padding(
                padding: const EdgeInsets.all(8).copyWith(top: 24),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Icon(Icons.live_tv),
                    Text(
                      ' FTube',
                      textScaleFactor: 1.5,
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: ListView.builder(
            itemCount: videos.length,
            itemBuilder: (context, index) {
              var video = videos.elementAt(index);
              return VideoListTile(
                video: video,
                onChange: (v) => onVideoEdited(v, index),
              );
            },
          ),
          // floatingActionButton: FloatingActionButton(
          //   child: const Icon(Icons.add),
          //   onPressed: () {
          //     showDialog(
          //       context: context,
          //       builder: (context) {
          //         return VideoDialog(
          //           title: 'Add a New Video',
          //           onSubmit: onVideoAdded,
          //           video: VideoInfo(), // Pass a default video or the one you want to edit
          //         );
          //       },
          //     );
          //   },
          // ),
        );
      },
    );
  }
}
