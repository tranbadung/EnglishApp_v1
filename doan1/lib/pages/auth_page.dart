// ignore_for_file: prefer_const_constructors

import 'package:doan1/pages/dashboard_page.dart';
import 'package:doan1/pages/login_or_register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){

          //user is logged in
           if(snapshot.hasData){
            return DashboardPage();
           }

          //user is NOT logged in
          else{
            return LoginOrRegisterPage();
          }
          
        },
      ),
    );
  }
}