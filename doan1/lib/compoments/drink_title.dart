// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:doan1/models/drink.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DrinkTitle extends StatelessWidget {
  final Drink drink;
  final void Function()?onTap;
  const DrinkTitle({
    super.key,
    required this.drink,
    required this.onTap,
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
       onTap: onTap,
       child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 28, 203, 51),
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 30),
         padding: const EdgeInsets.all(10),
        child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
            //image
           Center(
            child: Image.asset(
              drink.imagePath,
              height: 100,
              fit: BoxFit.contain,
            ),
           ),

           //text
           Text(
            drink.name,
            style: GoogleFonts.dmSerifDisplay(
              fontSize: 25,
              color: const Color.fromARGB(255, 255, 253, 253)
              ),
           )
        ],

        ),
       ),
    );
  }
}