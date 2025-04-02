import 'package:flutter/material.dart';

class ReviewFlashcardsScreen extends StatefulWidget {
  final List<Map<String, dynamic>> flashcards;
  final List<bool> learnedStatus;

  ReviewFlashcardsScreen({
    required this.flashcards,
    required this.learnedStatus,
  });

  @override
  _ReviewFlashcardsScreenState createState() => _ReviewFlashcardsScreenState();
}

class _ReviewFlashcardsScreenState extends State<ReviewFlashcardsScreen> {
  int currentIndex = 0;

  void markAsLearned(bool isLearned) {
    setState(() {
      if (isLearned) {
        widget.learnedStatus[currentIndex] = true; // Đánh dấu flashcard đã học
      }
      // Chuyển sang thẻ tiếp theo nếu còn
      if (currentIndex < widget.flashcards.length - 1) {
        currentIndex++;
      } else {
        // Quay lại màn hình trước nếu đã ôn xong
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ôn lại các thuật ngữ khó"),
        centerTitle: true,
      ),
      body: widget.flashcards.isEmpty
          ? Center(child: Text("Không có thẻ nào để ôn."))
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.flashcards[currentIndex]["front"], // Mặt trước
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  widget.flashcards[currentIndex]["back"], // Mặt sau
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => markAsLearned(false), // Đánh dấu "Chưa học"
                      child: Text("Chưa học"),
                    ),
                    ElevatedButton(
                      onPressed: () => markAsLearned(true), // Đánh dấu "Đã học"
                      child: Text("Đã học"),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
