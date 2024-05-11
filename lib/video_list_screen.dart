import 'package:flutter/material.dart';
import 'package:basic_app/video_service.dart'; // Import the fetchVideos function
import 'package:basic_app/video_detail_screen.dart'; // Import the VideoDetailScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: VideoListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class VideoListScreen extends StatefulWidget {
  @override
  _VideoListScreenState createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {
  List<dynamic> _videos = [];

  @override
  void initState() {
    super.initState();
    _loadVideos();
  }

  Future<void> _loadVideos() async {
    try {
      List<dynamic> videos = await fetchVideos();
      setState(() {
        _videos = videos;
      });
    } catch (e) {
      print('Error loading videos: $e');
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Videos'),
      ),
      body: _videos.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _videos.length,
        itemBuilder: (context, index) {
          final video = _videos[index];
          // Build UI to display video
          return GestureDetector(
            onTap: () {
              // Navigate to video detail screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoDetailScreen(video: video),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  video['title'],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Image.network(video['thumbnail_url']),
                Text(video['description']),
                Text('Channel: ${video['channel_name']}'),
                Text('Likes: ${video['likes']}'),
                SizedBox(height: 10), // Add spacing between videos
              ],
            ),
          );
        },
      ),
    );
  }
}
