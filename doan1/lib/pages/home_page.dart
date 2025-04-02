// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:doan1/compoments/food_tile.dart';
import 'package:doan1/models/food.dart';
import 'package:doan1/pages/context_page.dart';
import 'package:doan1/pages/food_details_page.dart';
import 'package:doan1/pages/quiz_page.dart';
import 'package:doan1/speak/pronuciation_screen.dart';
import 'package:doan1/youtube/video_list_sceen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //food menu
  List foodMenu = [

    //Học tiếng anh theo chủ đề
    Food(
     name: "Học tiếng anh với flashcard",
     imagePath: "lib/images/hi.png",
     ),

    //Học tiếng anh theo ngữ cảnh
    Food(
     name: "Học tiếng anh với Quiz",
     imagePath: "lib/images/hi1.png",
     ),

     // Học phát âm
     Food(
      name: "Học phát âm từ vựng",
      imagePath: "lib/images/hi1.png",
     ),

     // Học tiếng anh qua video
     Food(
      name: "Học tiếng anh qua video",
      imagePath: "lib/images/hi1.png",
     ),


  ];

  final pageOpen = [
    FoodDetailsPage(),
    // ContextPage(),
    QuizPage(),
    PronunciationScreen(),
    VideoListScreen(),

  ];

  //navigate to food item details page
  void navigateToFoodDetials(int index){
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => pageOpen[index]
      ),
    );
  }

  //user
  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
       backgroundColor: Colors.transparent,
       elevation: 0, // xác định độ cao bóng đổ

       leading: Icon(
        Icons.menu,
        color: Colors.grey[900],
       ),

       title: Text(
        'Luffy',
        style: TextStyle(
          color: Colors.grey[900],
        ),
       ),
        centerTitle: true, //căn giữa Text
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
         children: [
          
          //promo banner
          Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 133, 60, 55),
              borderRadius: BorderRadius.circular(20),
              ),
            margin: const  EdgeInsets.symmetric(horizontal: 25),
            padding: const EdgeInsets.all(25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
               Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //promo message
                   const Text(
                    'Xin Chào',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),       
                  ),
                
                const SizedBox(height: 20),
                  // //redeem button
                   Text(
                    currentUser.email!,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),


                  // MyButton(
                  //   onTap: (){},
                  //   text: "Redeem")
                ],
               ),

               //image
               Image.asset(
                'lib/images/chibichu.png',
                height: 100,
                
               )
              ],
            ),
          ),
          
          const SizedBox(height: 25),

          //search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              // enabled: false, mặ định TextField = true là được kích hoạt, ngược lại là không
              decoration: InputDecoration(
                //Mặc định (border): Khi không có tương tác
                // border: OutlineInputBorder(
                //   borderSide: BorderSide(color: Colors.white),
                //   borderRadius: BorderRadius.circular(20),
                // ),
              
              //Khi được chọn (focusedBorder): Khi người dùng nhấn vào.
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(20),
              ),
             
              //Khi được kích hoạt (enabledBorder): Khi được bật nhưng chưa được chọn.
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(20),
              ),
              hintText: "Search here..",
              ),
            ),
          ),

          const SizedBox(height: 25),

          //menu list
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 25.0),
             child: Text(
              "Danh mục",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
                fontSize: 18,
              ),
              ),
           ),

           const SizedBox(height: 10),

           Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal, // thiết lập hướng cuộn
              itemCount: foodMenu.length,
              itemBuilder: (context, index) => FoodTile(
                food: foodMenu[index],
                onTap: () => navigateToFoodDetials(index),
              ),
              )
           ),

           const SizedBox(height: 25),

           //popular food
           Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(20),
            ),
            
            margin: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
            padding: const EdgeInsets.all(20),
            child: Row(
              
              children: [
              //image
              Image.asset(
                'lib/images/chude.png',
                height: 60,
              ),
              const SizedBox(width: 20),
              //name
              Text(
                "Salmon Eggs",
                style: GoogleFonts.dmSerifDisplay(fontSize: 18),
              ),
              const SizedBox(width: 30),
            
              //heart
               const Icon(
                Icons.favorite_outline,
                color: Colors.grey,
                size: 28,
              )
            ],
            ),
           )

           
         ],
      ),
    );
  }
}