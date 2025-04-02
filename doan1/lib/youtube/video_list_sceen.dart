import 'package:doan1/api/youtube_api.dart';
import 'package:doan1/youtube/youtubevideo_player.dart';
import 'package:flutter/material.dart';


class VideoListScreen extends StatefulWidget {
  @override
  _VideoListScreenState createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {
  final YouTubeService _youtubeService = YouTubeService();
  List<Map<String, dynamic>> _videos = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchVideos();
  }

  Future<void> _fetchVideos() async {
    try {
      final videos = await _youtubeService.searchVideos('English conversation');
      setState(() {
        _videos = videos;
        _isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('English Learning Videos'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _videos.length,
              itemBuilder: (context, index) {
                final video = _videos[index];
                return ListTile(
                  leading: Image.network(video['thumbnail']!),
                  title: Text(video['title']!),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            YouTubeVideoPlayer(videoId: video['videoId']!),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
