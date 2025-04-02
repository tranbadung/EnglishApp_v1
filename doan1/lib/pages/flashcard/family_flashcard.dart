import 'package:doan1/controller/flashcard_controlle.dart';
import 'package:doan1/pages/flashcard/finish_page.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:get/get.dart';


class FamilyFlashcard extends StatelessWidget {
  final FlashcardController controller = Get.put(FlashcardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Family Flashcards"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Obx(() => Padding(
                padding: const EdgeInsets.all(8.0),
                child: LinearPercentIndicator(
                  lineHeight: 14.0,
                  percent: controller.progress.value,
                  backgroundColor: Colors.grey[300],
                  progressColor: Colors.blue,
                  center: Text(
                    "${(controller.progress.value * 100).toStringAsFixed(0)}%",
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              )),
          Expanded(
            child: Obx(() => controller.flashcards.isEmpty
                ? Center(child: Text("No flashcards found."))
                : Stack(
                    children: [
                      Center(
                        child: SizedBox(
                          height: 450,
                          child: Swiper(
                            itemBuilder: (BuildContext context, int index) {
                              final card = controller.flashcards[index];
                              return FlipCard(
                                onFlipDone: (isFront) {
                                  controller.flipCard(index, isFront);
                                },
                                direction: FlipDirection.HORIZONTAL,
                                front: _buildCardWithSound(card["front"]!, Colors.blue),

                                back: _buildCard(card["back"]!, Colors.green),
                              );
                            },
                            itemCount: controller.flashcards.length,
                            viewportFraction: 0.7,
                            scale: 0.2,
                            loop: false,
                            control: SwiperControl(),
                          ),
                        ),
                      ),
                      Obx(() {
                        if (controller.isCompleted.value) {
                          return Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.to(() => FinishScreen());
                                },
                                child: Text("Hoàn thành"),
                              ),
                            ),
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      }),
                    ],
                  )),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(String text, Color color) {
    return Container(
      height: 150,
      width: 200,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

    Widget _buildCardWithSound(String text, Color color) {
  print("Attempting to speak: $text"); // Log kiểm tra
  return Container(
    height: 150,
    width: 200,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        IconButton(
          onPressed: () {
            controller.speakText(text); // Gọi hàm phát âm
          },
          icon: Icon(Icons.volume_up, color: Colors.white),
        ),
      ],
    ),
  );
}


}
