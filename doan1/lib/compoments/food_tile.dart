// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:doan1/models/food.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodTile extends StatelessWidget {
  final Food food;
  final void Function()?onTap;

  const FoodTile({
    super.key,
    required this.food,
    required this.onTap,
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
          
        ),
        margin:  const EdgeInsets.only(left: 25),
        padding: const EdgeInsets.all(25),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //image
            Center(
              child: Image.asset(
                food.imagePath,
                height: 140,
                fit: BoxFit.contain, // Giữ tỷ lệ của hình ảnh

              ),
            ),
      
            //tex
            Text(
              food.name,
              style: GoogleFonts.dmSerifDisplay(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}