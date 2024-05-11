/// Holds information about an Internet video.
class VideoInfo {
  /// The title of the video.
  String title;

  /// The URL of the video's cover image.
  String coverImageUrl;

  /// The location from which to stream the video.
  String videoImageUrl;

  VideoInfo({this.title = "", this.coverImageUrl = "", this.videoImageUrl = ""});

  factory VideoInfo.fromJson(Map<String, dynamic> json) {
    return VideoInfo(
      title: json['title'] ?? "",
      coverImageUrl: json['cover_image_url'] ?? "",
      videoImageUrl: json['video_image_url'] ?? "",
    );
  }
}
