import 'dart:math';

import 'package:doan1/controller/flashcard_controlle.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

class QuizController extends GetxController {
  final FlutterTts flutterTts = FlutterTts();

   int currentIndex = 0;
  var correctAnswers = 0.obs; // Số câu trả lời đúng
  var incorrectAnswers = 0.obs; // Số câu trả lời sai
  var progress = 0.0.obs; // Tiến độ hoàn thành
  var totalQuestions = 0.obs; // Tổng số câu hỏi
    var attemptCount = 0.obs; // Số lần làm quiz
  var incorrectCards = <Map<String, dynamic>>[].obs; // Lưu danh sách các thẻ trả lời sai
   final FlashcardController flashcardController = Get.find(); // Lấy FlashcardController
 
  var currentCard = <String, dynamic>{}.obs; // Thẻ hiện tại
void initQuiz(int totalFlashcards) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    attemptCount.value++; // Tăng số lần làm quiz sau khi giao diện hoàn tất
    totalQuestions.value = totalFlashcards;
    correctAnswers.value = 0;
    incorrectAnswers.value = 0;
        currentCard.value = {}; // Reset thẻ hiện tại
    progress.value = 0.0;
    incorrectCards = <Map<String, dynamic>>[].obs; // Reset danh sách các thẻ trả lời sai
    getNextCard();
  });
}

// @override
// void onInit() {
//   super.onInit(); // Gọi lớp cha để giữ logic mặc định.
//   WidgetsBinding.instance.addPostFrameCallback((_) {
//     attemptCount.value = 0; // Đặt giá trị ban đầu cho biến `attemptCount`.
//   });
// }



  // Kiểm tra đáp án và cập nhật trạng thái
  bool checkAnswer(String userAnswer, Map<String, dynamic> currentCard) {
    String correctAnswer = currentCard['front'];

    // Kiểm tra đáp án
    bool isCorrect = userAnswer.toLowerCase() == correctAnswer.toLowerCase();

    // Cập nhật kết quả
    if (isCorrect) {
      correctAnswers.value++;
    } else {
      incorrectAnswers.value++; // Tăng số câu trả lời sai và 
      incorrectCards.add(Map<String, dynamic>.from(currentCard)); //thêm thẻ vào danh sách các thẻ trả lời sai dùng biến tạm 
    }

    // Cập nhật tiến độ
    progress.value = (correctAnswers.value + incorrectAnswers.value) / totalQuestions.value;
    // Lấy thẻ tiếp theo nếu chưa hoàn thành tiến độ
    if (progress.value < 1.0) { //1.0 là 100%
      getNextCard();
    }
    return isCorrect;
  }

 


  
   // Lấy thẻ theo thứ tự từ đầu đến cuối
 

  void getNextCard() {
    if (flashcardController.flashcards.isNotEmpty) {
      currentCard.value = flashcardController.flashcards[currentIndex];
      currentIndex = (currentIndex + 1) % flashcardController.flashcards.length;
    }
  }

 void retryWithIncorrectCards() {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    progress.value = 0.0; // Reset tiến độ
    if (incorrectCards.isNotEmpty) {
      currentCard.value = Map<String, dynamic>.from(incorrectCards[0]);
    } else {
      print('No incorrect cards to retry.');
    }
  });
}


  void checkAnswerRetry(String userAnswer) {
    String correctAnswer = currentCard['front'];
    bool isCorrect = userAnswer.toLowerCase() == correctAnswer.toLowerCase();
    if (isCorrect) {
      correctAnswers.value++;
      incorrectCards.removeAt(0);
      if (incorrectCards.isNotEmpty) {
        currentCard.value = Map<String, dynamic>.from(incorrectCards[0]);
      }
    }
  }
  
  Future<void> speakText(String text) async {
    try {
      await flutterTts.setLanguage("vi-VN");
      await flutterTts.setSpeechRate(0.5); // Thiết lập tốc độ
      await flutterTts.setPitch(1.0);      // Thiết lập cao độ
      await flutterTts.speak(text);       // Phát âm văn bản
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
