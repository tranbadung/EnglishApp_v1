// // import 'package:doan1/controller/pronuciation_controller.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';


// // class HistoryScreen extends StatelessWidget {
// //   final controller = Get.find<PronunciationController>();

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Lịch sử học'),
// //       ),
// //       body: Obx(
// //         () => ListView.builder(
// //           itemCount: controller.wordList.length,
// //           itemBuilder: (context, index) {
// //             final word = controller.wordList[index];
// //             return ListTile(
// //               title: Text(word['word']),
// //               subtitle: Text('Dịch: ${word['translation']}'),
// //               trailing: Icon(
// //                 word['learned'] ? Icons.check_circle : Icons.circle,
// //                 color: word['learned'] ? Colors.green : Colors.grey,
// //               ),
// //             );
// //           },
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:doan1/controller/pronuciation_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class HistoryScreen extends StatelessWidget {
//   final controller = Get.find<PronunciationController>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Lịch sử học'),
//         backgroundColor: Colors.grey[500],
//         centerTitle: true,
//       ),
//       body: Obx(
//         () => controller.wordList.isEmpty
//             ? Center(child: Text('Không có từ vựng nào trong lịch sử.'))
//             : ListView.builder(
//                 itemCount: controller.wordList.length,
//                 itemBuilder: (context, index) {
//                   final word = controller.wordList[index];
//                   final isLearned = controller.isWordLearned(word);

//                   return ListTile(
//                     title: Text(word['word']),
//                     subtitle: Text('Dịch: ${word['translation']}'),
//                     trailing: Icon(
//                       isLearned ? Icons.check_circle : Icons.circle,
//                       color: isLearned ? Colors.green : Colors.grey,
//                     ),
//                     onTap: () {
//                       // Hiển thị thông báo chi tiết khi nhấn vào từ
//                       Get.snackbar(
//                         'Thông tin từ vựng',
//                         isLearned
//                             ? 'Bạn đã học từ này.'
//                             : 'Bạn chưa học từ này.',
//                         snackPosition: SnackPosition.BOTTOM,
//                       );
//                     },
//                   );
//                 },
//               ),
//       ),
//     );
//   }
// }
import 'package:doan1/controller/pronuciation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryScreen extends StatelessWidget {
  final controller = Get.find<PronunciationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lịch sử học'),
        backgroundColor: Colors.grey[500],
        centerTitle: true,
      ),
      body: Obx(
() {
          final learnedWords = controller.wordList
              .where((word) => controller.isWordLearned(word))
              .toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tổng số từ đã học: ${learnedWords.length}',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: learnedWords.isEmpty
                    ? Center(
                        child: Text(
                          'Bạn chưa học từ nào.',
                          style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                        ),
                      )
                    : ListView.builder(
                        itemCount: learnedWords.length,
                        itemBuilder: (context, index) {
                          final word = learnedWords[index];

                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                            child: ListTile(
                              leading: Icon(
                                Icons.book,
                                color: Colors.blue,
                              ),
                              title: Text(
                                word['word'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text('Dịch: ${word['translation']}'),
                              trailing: Icon(
                                Icons.check_circle,
                                color: Colors.green,
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
 

