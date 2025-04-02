import 'dart:convert';
import 'package:http/http.dart' as http;

class YouTubeService {
  final String apiKey = 'AIzaSyAqtYMpAqpbxPpkyx-tS6EKwbrRZb6z70U'; // Thay bằng API Key của bạn

  Future<List<Map<String, dynamic>>> searchVideos(String query) async {
    final url = Uri.parse(
        'https://www.googleapis.com/youtube/v3/search?part=snippet&type=video&q=$query&key=$apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['items'] as List<dynamic>)
          .map((item) => {
                'videoId': item['id']?['videoId'] ?? '',
                'title': item['snippet']?['title'] ?? 'Unknown Title',
                'thumbnail': item['snippet']?['thumbnails']?['default']?['url'] ?? '',
              })
          .toList();
    } else {
      throw Exception('Failed to load videos');
    }
  }
}
