// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  //user
  final currentUser = FirebaseAuth.instance.currentUser!;

  //Hàm đăng xuất
  void signUserOut(){
    FirebaseAuth.instance.signOut();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Page"),
        backgroundColor: Colors.grey[500],
       
      ),
      body: ListView(
        children: [
          const SizedBox(height: 50),
          
          // profile pic
           const Icon(
            Icons.person,
            size: 72
            ),
 
           const SizedBox(height: 10),

            Text(
              currentUser.email!,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[700]
              ),
            ),

            const SizedBox(height: 40),

            //Đăng xuất

            GestureDetector(
              onTap: signUserOut,
              child: Container(
        padding:  const EdgeInsets.all(20),
        margin:  const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
          ),
        child:  Center(
          child: Text(
          "Đăng xuất",
          style:  const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            ),
          )
          ),
      ),
              
            )
        ],
      ),
    );
  }
}