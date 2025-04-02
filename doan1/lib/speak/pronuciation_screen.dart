// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:doan1/controller/pronuciation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PronunciationScreen extends StatelessWidget {
  final controller = Get.put(PronunciationController());

  PronunciationScreen() {
    // Tải danh sách từ vựng chung khi khởi tạo màn hình
    controller.fetchGlobalWords().then((words) {
      controller.wordList.value = words;
      if (words.isNotEmpty) {
        controller.targetWord.value =
            words[controller.currentIndex.value]['word'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 226, 213, 213),
      appBar: AppBar(
        title: Text('Học phát âm'),
        backgroundColor: const Color.fromARGB(255, 164, 202, 246),
        centerTitle: true,
      ),
      body: Obx(
        () => controller.wordList.isEmpty
            ? Center(child: Text('Không có từ vựng nào để học.'))
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Từ vựng: ${controller.targetWord.value}',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Bạn đã nói: ${controller.recognizedWord.value}',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      'Độ giống: ${(controller.similarity.value * 100).toStringAsFixed(2)}%',
                      style: TextStyle(
                        fontSize: 20,
                        color: controller.similarity.value > 0.7
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                    Text(
                      'Trạng thái: ${controller.isWordLearned(controller.wordList[controller.currentIndex.value]) ? 'Đã học' : 'Chưa học'}',
                      style: TextStyle(fontSize: 20, color: Colors.blue),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (controller.wordList.isNotEmpty) {
                          final wordId = controller
                              .wordList[controller.currentIndex.value]['id'];
                          await controller.markWordAsLearned(wordId);
                          controller.wordList.refresh();
                          Get.snackbar(
                              'Thành công', 'Đã đánh dấu từ là "Đã học"');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green, // Màu nền
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // Góc vuông
                        ),
                        padding: EdgeInsets.all(16), // Kích thước nút
                      ),
                      child: Icon(Icons.check, size: 24), // Biểu tượng dấu tích
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton.icon(
                          onPressed: controller.isListening.value
                              ? controller.stopListening
                              : controller.startListening,
                          icon: Icon(controller.isListening.value
                              ? Icons.mic_off
                              : Icons.mic), // Icon thay đổi theo trạng thái
                          label: Text(
                              controller.isListening.value ? 'Dừng' : 'Nói'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: controller.isListening.value
                                ? Colors.red
                                : Colors.blue,
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () =>
                              controller.speakText(controller.targetWord.value),
                          icon: Icon(Icons
                              .volume_up), // Sử dụng Icon widget để hiển thị biểu tượng
                          label: Text('Nghe từ'), // Đây là nhãn cho nút
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 96, 225, 100),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (controller.currentIndex.value > 0) {
                              controller.currentIndex.value--;
                              controller.targetWord.value = controller
                                      .wordList[controller.currentIndex.value]
                                  ['word'];

                            // Reset các trạng thái
    controller.recognizedWord.value = '';
    controller.similarity.value = 0.0;
                            } else {
                              Get.snackbar('Thông báo', 'Đây là từ đầu tiên!');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(0), // Góc vuông
                            ),
                            padding: EdgeInsets.all(
                                16), // Tăng kích thước nút để giống hình vuông
                          ),
                          child: Text('Quay lại từ trước'),
                        ),
                        ElevatedButton(
                          onPressed: controller.nextWord,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(0), // Góc vuông
                            ),
                            padding: EdgeInsets.all(
                                16), // Tăng kích thước nút để giống hình vuông
                          ),
                          child: Text('Từ tiếp theo'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
