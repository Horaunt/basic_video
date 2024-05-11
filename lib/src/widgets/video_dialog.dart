import 'package:flutter/material.dart';
import '../models/video_info.dart';

class VideoDialog extends StatefulWidget {
  final String title;
  final void Function(VideoInfo) onSubmit;
  final VideoInfo video;

  const VideoDialog({
    required this.title,
    required this.onSubmit,
    required this.video, // Marking video parameter as required
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _VideoDialogState();
}

class _VideoDialogState extends State<VideoDialog> {
  var titleCtrl = TextEditingController();
  var imageUrlCtrl = TextEditingController();
  var videoUrlCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleCtrl.text = widget.video.title;
    imageUrlCtrl.text = widget.video.coverImageUrl;
    videoUrlCtrl.text = widget.video.videoImageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            controller: titleCtrl,
            decoration: const InputDecoration(hintText: 'Title'),
          ),
          TextFormField(
            controller: imageUrlCtrl,
            decoration: const InputDecoration(hintText: 'Cover Image'),
          ),
          TextFormField(
            controller: videoUrlCtrl,
            decoration: const InputDecoration(hintText: 'Video URL'),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('CANCEL'),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: const Text('SUBMIT'),
          onPressed: () {
            Navigator.pop(context);
            final VideoInfo video = VideoInfo(
              title: titleCtrl.text,
              coverImageUrl: imageUrlCtrl.text,
              videoImageUrl: videoUrlCtrl.text,
            );
            widget.onSubmit(video);
          },
        ),
      ],
    );
  }
}
