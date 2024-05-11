import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<dynamic>> fetchVideos() async {
  final response = await http.get(
    Uri.parse('https://yrnrfhppsmdkxgyfceib.supabase.co/rest/v1/Basic_video'),
    headers: {
      'apikey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlybnJmaHBwc21ka3hneWZjZWliIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQ5NzU5MzYsImV4cCI6MjAzMDU1MTkzNn0.eizsrPFTicYLHCltuubUsC7j7NOclF2Ygsb4KQq30_E',
    },
  );

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON
    // response.body contains the data returned by Supabase
    return jsonDecode(response.body);
  } else {
    // If the server did not return a 200 OK response, throw an error.
    throw Exception('Failed to load videos');
  }
}
