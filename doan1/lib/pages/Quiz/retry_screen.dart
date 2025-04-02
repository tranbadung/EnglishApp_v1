import 'package:doan1/controller/quiz_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RetryIncorrectScreen extends StatelessWidget {
  final QuizController quizController = Get.find();

  @override
  Widget build(BuildContext context) {
    // Gọi init khi bắt đầu màn hình
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (quizController.incorrectCards.isEmpty) {
        Get.back(); // Quay lại nếu danh sách rỗng
      } else {
        quizController.retryWithIncorrectCards();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("Retry Incorrect Questions"),
        backgroundColor: Colors.green,
      ),
      body: Obx(() {
        if (quizController.incorrectCards.isEmpty) {
          return Center(
            child: Text("All incorrect questions have been answered!"),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "What is the meaning of:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                quizController.currentCard['back'],
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 20),
                        // Nút phát âm
          ElevatedButton.icon(
            onPressed: () {
              // Phát âm phần front
              quizController.speakText(quizController.currentCard['front'] ?? "");
            },
            icon: Icon(Icons.volume_up),
            label: Text("Play Sound"),
          ),
           SizedBox(height: 20),
              TextField(
                onSubmitted: (value) {
                  if (value.trim().isNotEmpty) {
                    quizController.checkAnswerRetry(value.trim());
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Please enter an answer."),
                        backgroundColor: Colors.orange,
                      ),
                    );
                  }

                  // Kiểm tra nếu danh sách câu sai đã hoàn thành
                  if (quizController.incorrectCards.isEmpty) {
                    Get.back(); // Quay lại màn hình trước
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Your answer",
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
