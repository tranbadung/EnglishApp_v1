import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:string_similarity/string_similarity.dart';

class PronunciationController extends GetxController {
  late stt.SpeechToText speech;
  late FlutterTts flutterTts;

//Khai báo các biến cần thiết
  var isListening = false.obs;
  var recognizedWord = ''.obs;
  var targetWord = ''.obs;
  var similarity = 0.0.obs;

  var wordList = <Map<String, dynamic>>[].obs;
  var currentIndex = 0.obs;

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    speech = stt.SpeechToText(); // Khởi tạo speech
    flutterTts = FlutterTts(); // Khởi tạo flutterTts
    //   loadUserWords();
    //     // Lắng nghe trạng thái đăng nhập
    // auth.authStateChanges().listen((User? user) {
    //   if (user != null) {
    //     loadUserWords();
    //   } else {
    //     wordList.clear();
    //     targetWord.value = '';
    //     currentIndex.value = 0;
    //   }
    // });
  }

  Future<List<Map<String, dynamic>>> fetchGlobalWords() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('global_words').get(); // Lấy danh sách từ vựng chung

      return snapshot.docs.map((doc) { // Chuyển đổi dữ liệu từ snapshot
        final data = doc.data();
        return {
          'id': doc.id,
          'word': data['word'],
          'translation': data['translation'],
          'learnedBy': List<String>.from(data['learnedBy'] ?? []),
        };
      }).toList();
    } catch (e) {
      print('Lỗi khi tải từ vựng: $e');
      return [];
    }
  }

  // Future<void> loadUserWords() async {
  //   wordList.value = await fetchUserWords();
  //   if (wordList.isNotEmpty) {
  //     targetWord.value = wordList[currentIndex.value]['word'];
  //   }
  // }

  // Future<List<Map<String, dynamic>>> fetchUserWords() async {
  //   final userId = auth.currentUser?.uid;
  //   if (userId == null) return [];

  //   final snapshot = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(userId)
  //       .collection('words')
  //       .get();

  //   return snapshot.docs.map((doc) {
  //     final data = doc.data();
  //     return {
  //       'id': doc.id,
  //       'word': data['word'],
  //       'translation': data['translation'],
  //       'learned': data['learned'],
  //     };
  //   }).toList();
  // }

  Future<void> startListening() async {
    bool available = await speech.initialize(); // Khởi tạo speech
    if (available) {
      isListening.value = true;
     speech.listen(onResult: (result) {
  recognizedWord.value = result.recognizedWords; // Lấy từ nhận dạng

  // Nếu từ nhận dạng không giống chút nào với từ mục tiêu, đặt similarity về 0
  if (recognizedWord.value.isEmpty || targetWord.value.isEmpty) {
    similarity.value = 0.0;
  } else {
    similarity.value = targetWord.value.similarityTo(recognizedWord.value);
  }

  // Đảm bảo trạng thái hiển thị hợp lý
  if (similarity.value < 0.8) { // Đặt ngưỡng tương đồng, ví dụ 80%
    print("Không khớp!");
  }
});
    } else {
      print('Không thể kết nối với máy chủ nhận dạng giọng nói.');
    }
  }

  void stopListening() {
    speech.stop();
    isListening.value = false;
  }

  Future<void> speakText(String text) async {
    await flutterTts.setLanguage('vi-VN');
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(text);
  }

//   Future<void> markWordAsLearned(String wordId) async {
//   final userId = auth.currentUser?.uid;
//   if (userId == null) return;

//   await FirebaseFirestore.instance
//       .collection('users')
//       .doc(userId)
//       .collection('words')
//       .doc(wordId)
//       .update({'learned': true});
// }

  Future<void> markWordAsLearned(String wordId) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      print('Người dùng chưa đăng nhập!');
      return;
    }

    try {
      await FirebaseFirestore.instance
          .collection('global_words')
          .doc(wordId)
          .update({
        'learnedBy':
            FieldValue.arrayUnion([userId]), // Thêm userId vào danh sách
      });
      print('Đã đánh dấu từ đã học.');
    } catch (e) {
      print('Lỗi khi đánh dấu từ: $e');
    }
  }

  bool isWordLearned(Map<String, dynamic> word) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    return word['learnedBy'] != null && word['learnedBy'].contains(userId);
  }

  void nextWord() {
    if (currentIndex.value < wordList.length - 1) {
      currentIndex.value++;
      targetWord.value = wordList[currentIndex.value]['word'];
          // Reset trạng thái
    recognizedWord.value = '';
    similarity.value = 0.0;

    } else {
      Get.snackbar('Thông báo', 'Bạn đã học hết các từ!');
    }
  }
}
