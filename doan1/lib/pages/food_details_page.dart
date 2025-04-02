// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:doan1/compoments/drink_title.dart';
import 'package:doan1/models/drink.dart';
import 'package:doan1/pages/flashcard/family_flashcard.dart';
import 'package:flutter/material.dart';

class FoodDetailsPage extends StatefulWidget {
 
   FoodDetailsPage({
    super.key,

    });

  @override
  State<FoodDetailsPage> createState() => _FoodDetailsPageState();
}

class _FoodDetailsPageState extends State<FoodDetailsPage> {
   List drinkMenu = [
    Drink(
      name: "Family",
      imagePath: "lib/images/chude.png"
      ),

      Drink(
      name: "School",
      imagePath: "lib/images/chude.png"
      ),

       Drink(
      name: "School",
      imagePath: "lib/images/chude.png"
      ),
       Drink(
      name: "School",
      imagePath: "lib/images/chude.png"
      ),
       Drink(
      name: "School",
      imagePath: "lib/images/chude.png"
      ),
       Drink(
      name: "School",
      imagePath: "lib/images/chude.png"
      ),
   ];

   final pageOpen = [
    FamilyFlashcard(),
   

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

      
     
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Học tiếng anh theo chủ đề"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: drinkMenu.length,
              itemBuilder: (context, index) => Column(
                children: [
                  DrinkTitle(
                    drink: drinkMenu[index],
                     onTap: () => navigateToFoodDetials(index),
                     ),
                     SizedBox(height: 10),
                ],
              ),
                
              ) ),
        ],
      )
      
    );
  }
}