import 'package:doan1/pages/chatAl/chat_page.dart';
import 'package:doan1/pages/home_page.dart';
import 'package:doan1/pages/profile_page.dart';
import 'package:doan1/pages/quiz_page.dart';
import 'package:doan1/pages/translateScreen/translate_screen.dart';
import 'package:doan1/speak/history_screen.dart';
import 'package:doan1/speak/pronuciation_screen.dart';
import 'package:doan1/youtube/video_list_sceen.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
     const HomePage(),
    // const QuizPage(),
     const ChatPage(),
    // VideoListScreen(),
     //PronunciationScreen(),
     const ProfilePage(),
   // HistoryScreen(),
  ];

   void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar
      (
         

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem
          (
            icon: Icon(Icons.home),
            label: 'Home',
          ),

          // BottomNavigationBarItem(
          //   icon: Icon(Icons.question_answer),
          //   label: 'Quiz',
          //   ),

            BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
            ),

          BottomNavigationBarItem
          (
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
         ),
    );
  }
}