// import 'package:doan1/api/chatgpt_api.dart';
// import 'package:doan1/models/chatmessage.dart';
// import 'package:doan1/pages/chatAl/chat_widget.dart';
// import 'package:flutter/material.dart';

// class ChatPage extends StatefulWidget {
//   const ChatPage({super.key});

//   @override
//   State<ChatPage> createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {

//   final _textController = TextEditingController();
//   final _scrollController = ScrollController();
//   final List<ChatMessage> _messages = [];
//   late bool isLoading;
//   ChatGPTApi chatGPTApi = ChatGPTApi(
//     apiKey: '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'
//     );

//   @override
//   void initState() {
//     super.initState();
//         isLoading = false;
//   }
 
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 100,
//         title: const Padding(
//           padding: EdgeInsets.all(8.0),
//           child: Text(
//             "OpenAI's ChatGPT Flutter",
//             maxLines: 2,
//             textAlign: TextAlign.center,
//           ),
//         ),
//         backgroundColor: const Color(0xff10a37f),
//       ),
//       backgroundColor: Colors.white,
//       body: _buildBody(context),
//     );
//   }

//   Widget _buildBody(BuildContext context) {
//     return SafeArea(
//       child: Column(
//         children: [
//           Expanded(
//             child: _buildList(),
//           ),
//           Visibility(
//             visible: isLoading,
//             child: const Padding(
//               padding: EdgeInsets.all(8.0),
//               child: CircularProgressIndicator(
//                 color: Color(0xff10a37f),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 _buildInput(),
//                 const SizedBox(width: 5),
//                 _buildSubmit(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildList() {
//     if (_messages.isEmpty) {
//       return Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           CircleAvatar(
//             backgroundColor: const Color(0xff10a37f),
//             radius: 50,
//             // child: Image.asset(
//             //   'assets/bot.png',
//             //   color: Colors.white,
//             //   scale: 0.6,
//             // ),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
//             child: Text(
//               'Hi, I\'m Duy\nTell me your dreams and i\'ll make them happen',
//               style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                     color: Colors.black,
//                   ),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ],
//       );
//     }

//     return ListView.builder(
//       physics: const BouncingScrollPhysics(),
//       controller: _scrollController,
//       itemCount: _messages.length,
//       itemBuilder: (context, index) {
//         var message = _messages[index];
//         return ChatMessageWidget(
//           text: message.text,
//           chatMessageType: message.chatMessageType,
//         );
//       },
//     );
//   }

//     Expanded _buildInput() {
//     return Expanded(
//       child: TextField(
//         textCapitalization: TextCapitalization.sentences,
//         minLines: 1,
//         maxLines: 9,
//         controller: _textController,
//         decoration: InputDecoration(
//           filled: true,
//           fillColor: Colors.grey[300],
//           focusedBorder: InputBorder.none,
//           enabledBorder: InputBorder.none,
//           errorBorder: InputBorder.none,
//           disabledBorder: InputBorder.none,
//         ),
//       ),
//     );
//   }

//    Widget _buildSubmit() {
//     return Visibility(
//       visible: !isLoading,
//       child: Container(
//         decoration: BoxDecoration(
//           color: const Color(0xff10a37f),
//           borderRadius: BorderRadius.circular(
//             6,
//           ),
//         ),
//         child: IconButton(
//           icon: const Icon(
//             Icons.send_rounded,
//             color: Colors.white,
//           ),
//                  onPressed: () async {
//             setState(
//               () {
//                 _messages.add(
//                   ChatMessage(
//                     text: _textController.text,
//                     chatMessageType: ChatMessageType.user,
//                   ),
//                 );
//                 isLoading = true;
//               },
//             );
//             final input = _textController.text;
//             _textController.clear();
//             Future.delayed(const Duration(milliseconds: 50))
//                 .then((_) => _scrollDown());
//             chatGPTApi.complete(input).then((value) {
//               setState(() {
//                 isLoading = false;
//                 _messages.add(
//                   ChatMessage(
//                     text: value,
//                     chatMessageType: ChatMessageType.bot,
//                   ),
//                 );
//               });
//             }).catchError((error) {
//               setState(
//                 () {
//                   final snackBar = SnackBar(
//                     content: Text(error.toString()),
//                   );
//                   ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                   isLoading = false;
//                 },
//               );
//             });
//           },
//         ),
//       ),
//     );
//   }

//   void _scrollDown() {
//     _scrollController.animateTo(
//       _scrollController.position.maxScrollExtent,
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeOut,
//     );
//   }
 
// }