import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/video_info.dart';
import 'video_list.dart';

class VideoApp extends StatefulWidget {
  const VideoApp({Key? key});

  @override
  State<StatefulWidget> createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  List<VideoInfo> videos = [];

  @override
  void initState() {
    super.initState();
    fetchVideoDetails();
  }

  Future<void> fetchVideoDetails() async {
    final response = await http.get(Uri.parse('https://yrnrfhppsmdkxgyfceib.supabase.co/rest/v1/video?apikey=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlybnJmaHBwc21ka3hneWZjZWliIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQ5NzU5MzYsImV4cCI6MjAzMDU1MTkzNn0.eizsrPFTicYLHCltuubUsC7j7NOclF2Ygsb4KQq30_E'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        videos = data.map((videoJson) => VideoInfo.fromJson(videoJson)).toList();
      });
    } else {
      throw Exception('Failed to load video details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Video List'),
        ),
        body: VideoList(
          videos: videos,
          onVideoAdded: (video) {
            setState(() => videos.add(video));
          },
          onVideoEdited: (video, index) {
            setState(() => videos[index] = video);
          },
        ),
      ),
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.green,
      ),
    );
  }
}

void main() {
  runApp(const VideoApp());
}
