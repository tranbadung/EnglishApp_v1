import 'package:doan1/controller/quiz_controller.dart';
import 'package:doan1/pages/Quiz/retry_screen.dart';
import 'package:doan1/pages/dashboard_page.dart';
import 'package:doan1/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ResultScreen extends StatelessWidget {
  final QuizController quizController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kết quả bài kiểm tra"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Hoàn thành bài kiểm tra!",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Obx(() => Text(
                    "Số câu đúng: ${quizController.correctAnswers.value}",
                    style: TextStyle(fontSize: 18),
                  )),
              Obx(() => Text(
                    "Số câu sau: ${quizController.incorrectCards.length}",
                    style: TextStyle(fontSize: 18),
                  )),
                  Obx(() => Text('Số lần làm lại : ${quizController.attemptCount.value}')),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Điều hướng đến màn hình làm lại các câu sai
                  Get.to(() => RetryIncorrectScreen());
                },
                child: Text("Làm lại các câu sai"),
              ),
              SizedBox(height: 20),
              Obx(() {
                // Hiển thị nếu không còn câu sai
                if (quizController.incorrectCards.isEmpty) {
                  return Text(
                    "You have answered all questions correctly!",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
                  );
                }
                return SizedBox.shrink();
              }),
                            SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Điều hướng đến màn hình làm lại các câu sai
                         //quizController.resetQuizState(quizController.totalQuestions.value); // Reset trạng thái quiz


                  Get.to(() => DashboardPage());
                },
                child: Text("Quay lại trang chủ "),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
