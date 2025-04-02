import 'package:doan1/pages/Quiz/quiz_screen.dart';
import 'package:doan1/pages/flashcard/family_flashcard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FinishScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 215, 210, 210),
      appBar: AppBar(
        title: Text("Hoàn thành"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Bạn đã hoàn thành hết tất cả flashcard!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.offAll(() => FamilyFlashcard());
              },
              child: Text("Ôn lại Flashcards"),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: (){
                
                Get.to(()=> QuizScreen());
              },
               child: Text("Kiểm tra"),
               ),
          ],
        ),
      ),
    );
  }
}
