// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan1/models/quiz.dart';
import 'package:doan1/pages/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late List<Quiz> questions = [];
  int currentQuestionIndex = 0;
  int score = 0;
  List<String?> userAnswers = []; // Lưu đáp án đã chọn của từng câu hỏi
  List<bool?> questionStates = []; // Trạng thái của từng câu hỏi: null, true, false
  int remainingTime = 300; // 300 giây = 5 phút
  Timer? timer;

  @override
  void initState() {
    super.initState();
    fetchQuestions();
    startTimer(); // Bắt đầu đồng hồ đếm ngược
  }

  @override
  void dispose() {
    timer?.cancel(); // Hủy Timer khi thoát khỏi màn hình
    super.dispose();
  }

  Future<void> fetchQuestions() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('Quiz').limit(10).get();

    setState(() {
      questions = snapshot.docs.map((doc) {
        final List<String> options = List<String>.from(doc['option'] as List);
        return Quiz(
          question: doc['question'].toString(),
          option: options,
          correctAnswer: doc['correctAnswer'].toString(),
        );
      }).toList();
      // Khởi tạo danh sách userAnswers và questionStates với giá trị mặc định
      userAnswers = List<String?>.filled(questions.length, null);
      questionStates = List<bool?>.filled(questions.length, null);
    });
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingTime > 0) {
          remainingTime--;
        } else {
          timer.cancel();
          showResultDialog(); // Tự động nộp bài khi hết giờ
        }
      });
    });
  }
    void goToNextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      showResultDialog(); // Hiển thị kết quả nếu là câu cuối
    }
  }

  void goToPreviousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
    }
  }

  void goToQuestion(int index) {
    setState(() {
      currentQuestionIndex = index;
    });
  }

  void updateAnswer(String selectedOption) {
    setState(() {
      String? previousAnswer = userAnswers[currentQuestionIndex];
      userAnswers[currentQuestionIndex] = selectedOption;
      if (previousAnswer != selectedOption) {
        String correctAnswer = questions[currentQuestionIndex].correctAnswer;
        if (selectedOption == correctAnswer) {
          score++;
        }
        if (previousAnswer == correctAnswer) {
          score--;
        }
      }
    });
  }

  void evaluateAnswers() {
    setState(() {
      for (int i = 0; i < questions.length; i++) {
        if (userAnswers[i] != null) {
          questionStates[i] = userAnswers[i] == questions[i].correctAnswer;
        } else {
          questionStates[i] = null; // Câu chưa trả lời
        }
      }
    });
  }

  void showResultDialog() {
    timer?.cancel();
    evaluateAnswers(); // Đánh giá câu trả lời
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Quiz Result',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text('Your Quiz score: $score / ${questions.length}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  currentQuestionIndex = 0;
                  score = 0;
                  userAnswers = List<String?>.filled(questions.length, null);
                  questionStates = List<bool?>.filled(questions.length, null);
                  remainingTime = 300;
                  startTimer();
                });
              },
              child: const Text('Restart Quiz'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DashboardPage(),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Text('Go to Home'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text(
          'Quiz Page',
          style: GoogleFonts.aDLaMDisplay(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      
      body: (questions.isNotEmpty)
          ? Column(
              children: [
                SizedBox(height: 15),
                // Thanh điều hướng hiển thị danh sách câu hỏi
                Container(
                  height: 50,
                  color: Colors.grey[200],
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: questions.length,
                    itemBuilder: (context, index) {
                      Color color;
                      if (questionStates[index] == true) {
                        color = Colors.green; // Đúng
                      } else if (questionStates[index] == false) {
                        color = Colors.red; // Sai
                      } else {
                        color = Colors.white; // Chưa trả lời
                      }

                      return GestureDetector(
                        onTap: () => goToQuestion(index),
                        child: Container(
                          width: 50,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: color,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              color: color == Colors.white
                                  ? Colors.black
                                  : Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Time Remaining: ${remainingTime ~/ 60}:${(remainingTime % 60).toString().padLeft(2, '0')}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Question ${currentQuestionIndex + 1}/${questions.length}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            questions[currentQuestionIndex].question,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            children: questions[currentQuestionIndex]
                                .option
                                .map((option) {
                              return RadioListTile<String>(
                                title: Text(option),
                                value: option,
                                groupValue: userAnswers[currentQuestionIndex],
                                onChanged: (value) {
                                  if (value != null) {
                                    updateAnswer(value);
                                  }
                                },
                              );
                            }).toList(),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: currentQuestionIndex > 0
                                  ? goToPreviousQuestion
                                  : null,
                              child: const Text('Previous'),
                            ),
                            ElevatedButton(
                              onPressed: userAnswers[currentQuestionIndex] != null
                                  ? goToNextQuestion
                                  : null,
                              child: Text(currentQuestionIndex ==
                                      questions.length - 1
                                  ? 'Finish'
                                  : 'Next'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
