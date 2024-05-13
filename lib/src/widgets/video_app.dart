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
  List<VideoInfo> filteredVideos = [];

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
        filteredVideos = videos; // Initially set filtered videos to all videos
      });
    } else {
      throw Exception('Failed to load video details');
    }
  }

  void filterVideos(String query) {
    setState(() {
      filteredVideos = videos
          .where((video) =>
          video.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Video List'),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                final String? query = await showSearch(
                  context: Scaffold.of(context).context,
                  delegate: _CustomSearchDelegate(),
                );
                if (query != null) {
                  filterVideos(query);
                }
              },
            ),
          ],
        ),
        body: VideoList(
          videos: filteredVideos,
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

class _CustomSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text('Searching for "$query"...'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Suggestions based on previous queries or any other logic
    return Center(
      child: Text('Type to search...'),
    );
  }
}

void main() {
  runApp(const VideoApp());
}