import 'package:flutter/material.dart';

class ContextPage extends StatefulWidget {
  const ContextPage({super.key});

  @override
  State<ContextPage> createState() => _ContextPageState();
}

class _ContextPageState extends State<ContextPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello'),
      ),
    );
  }
}