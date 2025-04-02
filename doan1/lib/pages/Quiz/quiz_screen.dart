import 'package:doan1/controller/flashcard_controlle.dart';
import 'package:doan1/controller/quiz_controller.dart';
import 'package:doan1/pages/Quiz/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuizScreen extends StatelessWidget {
  final TextEditingController textEditingController = TextEditingController();

  final FlashcardController flashcardController =
      Get.find(); // Lấy FlashcardController
  final QuizController quizController =
      Get.put(QuizController()); // Khởi tạo QuizController

  QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Khởi tạo quiz với tổng số flashcards
    quizController.initQuiz(flashcardController.flashcards.length);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "What is the meaning of:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
            Obx(() {
  final currentCard = quizController.currentCard;

  // Phát âm phần front khi card thay đổi
  if (currentCard.isNotEmpty) {
    quizController.speakText(currentCard['front'] ?? ""); // Sử dụng phần front
  }

  return Column(
    children: [
      Text(
        currentCard['back'] ?? "Loading...",
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
      const SizedBox(height: 10),
      ElevatedButton.icon(
        onPressed: () {
          quizController.speakText(currentCard['front'] ?? ""); // Phát âm phần front
        },
        icon: const Icon(Icons.volume_up),
        label: const Text("Play"),
      ),
    ],
  );
}),

              const SizedBox(height: 20),
              TextField(
                controller: textEditingController,
                decoration: const InputDecoration(
                  hintText: "Enter your answer",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final value = textEditingController.text.trim();

                  final isCorrect = quizController.checkAnswer(
                    value,
                    quizController.currentCard,
                  );

                  if (isCorrect) {
                    Get.snackbar(
                      "Result",
                      "Correct!",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                    );
                  } else {
                    Get.snackbar(
                      "Result",
                      "Incorrect!",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                  // Xóa nội dung TextField
                  textEditingController.clear();

                  // Kiểm tra nếu quiz hoàn thành
                  if (quizController.progress.value == 1.0) {
                    // Chuyển đến màn hình kết quả
                    Get.to(() => ResultScreen());
                  }
                },
                child: const Text("Submit"),
              ),
              const SizedBox(height: 20),
              Obx(() => LinearProgressIndicator(
                    value: quizController.progress.value,
                    backgroundColor: Colors.grey[300],
                    color: Colors.blue,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
