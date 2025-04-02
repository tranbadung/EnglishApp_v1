import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

class FlashcardController extends GetxController {
  final CollectionReference flashcardsCollection =
  FirebaseFirestore.instance.collection('flashcards');
  final FlutterTts flutterTts = FlutterTts();


  var flashcards = <Map<String, dynamic>>[].obs; // Danh sách flashcards
  var flippedCards = <bool>[].obs; // Trạng thái thẻ đã lật
  var progress = 0.0.obs; // Phần trăm tiến độ
  var isCompleted = false.obs; // Trạng thái hoàn thành

  @override
  void onInit() {
    super.onInit();
    _loadFlashcards();
  }

  void _loadFlashcards() {
    flashcardsCollection.snapshots().listen((snapshot) {
      flashcards.value = snapshot.docs.map((doc) {
        try {
          return {
            "front": doc['front'],
            "back": doc['back'],
          };
        } catch (e) {
          return {
            "front": "Unknown",
            "back": "Unknown",
          };
        }
      }).toList();
      flippedCards.value = List<bool>.filled(flashcards.length, false);
      _updateProgress();
    });
  }

  void flipCard(int index, bool isFront) {
    if (!isFront && !flippedCards[index]) {
      flippedCards[index] = true;
      _updateProgress();
    }
  }
 
  void _updateProgress() {
    int flippedCount = flippedCards.where((flipped) => flipped).length;
    progress.value = flashcards.isEmpty ? 0 : flippedCount / flashcards.length;
    isCompleted.value = progress.value == 1.0;
  }

  Future<void> listSupportedLanguages() async {
  var languages = await flutterTts.getLanguages;
  print("Supported languages: $languages");
}


Future<void> speakText(String text) async {
  try {
    print("Speaking: $text");
    await flutterTts.setLanguage("vi-VN"); // Sử dụng tiếng Việt



    await flutterTts.setSpeechRate(0.5); // Tốc độ đọc
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
  } catch (e) {
    print("Error speaking: $e");
  }
}





  @override
  void onClose() {
    flutterTts.stop(); // Dừng TTS khi không dùng
    super.onClose();
  }

}
