import 'package:doan1/controller/flashcard_controlle.dart';
import 'package:doan1/controller/quiz_controller.dart';
import 'package:doan1/pages/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Khởi tạo Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Khởi tạo FlashcardController
  Get.put(FlashcardController());
 
  Get.put(QuizController()); 

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flashcard App',
      home: AuthPage(),
    );
  }
}
