import 'package:flutter/material.dart';
import 'package:basic_app/video_service.dart'; // Import the fetchVideos function

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
  List<dynamic> _filteredVideos = [];

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
        _filteredVideos = videos; // Initialize filtered videos with all videos
      });
    } catch (e) {
      print('Error loading videos: $e');
      // Handle error
    }
  }

  void _searchVideos(String query) {
    setState(() {
      _filteredVideos = _videos.where((video) {
        // Filter videos based on title, description, or any other criteria
        return video['title'].toLowerCase().contains(query.toLowerCase()) ||
            video['description'].toLowerCase().contains(query.toLowerCase()) ||
            video['channel_name'].toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Videos'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: VideoSearchDelegate());
            },
          ),
        ],
      ),
      body: _filteredVideos.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _filteredVideos.length,
        itemBuilder: (context, index) {
          final video = _filteredVideos[index];
          // Build UI to display video
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                video['title'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              // Image.network(video['thumbnail_url']),
              Text(video['description']),
              Text('Channel: ${video['channel_name']}'),
              Text('Likes: ${video['likes']}'),
              SizedBox(height: 10), // Add spacing between videos
            ],
          );
        },
      ),
    );
  }
}

class VideoSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
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
    // Logic to display search results
    return Center(
      child: Text('Search results for: $query'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Suggestions based on search query (optional)
    return Center(
      child: Text('Search suggestions for: $query'),
    );
  }
}