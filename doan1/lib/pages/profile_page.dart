// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:doan1/speak/history_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

// class _ProfilePageState extends State<ProfilePage> {

//   //user
//   final currentUser = FirebaseAuth.instance.currentUser!;

//   //Hàm đăng xuất
//   void signUserOut(){
//     FirebaseAuth.instance.signOut();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Profile Page"),
//         centerTitle: true,
//         backgroundColor: Colors.grey[500],
       
//       ),
//       body: ListView(
//         children: [
//           const SizedBox(height: 50),
          
//           // profile pic
//            const Icon(
//             Icons.person,
//             size: 72
//             ),
 
//            const SizedBox(height: 10),

//             Text(
//               currentUser.email!,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: Colors.grey[700]
//               ),
//             ),

//             const SizedBox(height: 40),

//             //Lịch sử học
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 30),
//               child: ElevatedButton(
//                 onPressed: (){
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => HistoryScreen()),
//                     );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   //backgroundColor: Colors.grey[500],
//                   padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
//                       shadowColor: Colors.grey, // Màu bóng
//                       minimumSize: Size(15, 10), // Kích thước tối thiểu
              
              
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20)
//                   )
//                 ),
//                 child: Text("Lịch sử học"),
//               ),
//             ),
             
//              const SizedBox(height: 20),
//             //Đăng xuất

//             GestureDetector(
//               onTap: signUserOut,
//               child: Container(
//         padding:  const EdgeInsets.all(20),
//         margin:  const EdgeInsets.symmetric(horizontal: 30),
//         decoration: BoxDecoration(
//           color: Colors.black,
//           borderRadius: BorderRadius.circular(8),
//           ),
//         child:  Center(
//           child: Text(
//           "Đăng xuất",
//           style:  const TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 16,
//             ),
//           )
//           ),
//       ),
              
//             )
//         ],
//       ),
//     );
//   }
// }

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
      backgroundColor: const Color.fromARGB(255, 216, 207, 207),
      appBar: AppBar(
        title: Text("Profile Page"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 11, 190, 59),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 50),
          
          // profile pic
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(currentUser.photoURL ?? 'https://via.placeholder.com/150'),
          ),

          const SizedBox(height: 10),

          Text(
            currentUser.displayName ?? 'User Name',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            currentUser.email!,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[700],
            ),
          ),

          const SizedBox(height: 40),

          //Lịch sử học
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: ElevatedButton.icon(
              onPressed: () {
                                   Navigator.push(
                   context,
                    MaterialPageRoute(builder: (context) => HistoryScreen()),
                     );
              },
              icon: Icon(Icons.history),
              label: Text('Lịch sử học'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 178, 188, 197),
                padding: EdgeInsets.symmetric(vertical: 15),
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Đăng xuất
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: ElevatedButton.icon(
              onPressed: signUserOut,
              icon: Icon(Icons.logout),
              label: Text('Đăng xuất'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 197, 191, 190),
                padding: EdgeInsets.symmetric(vertical: 15),
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}