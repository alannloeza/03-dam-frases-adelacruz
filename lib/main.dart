import 'package:flutter/material.dart';

void main() {
  runApp(const FrasesApp());
}

class FrasesApp extends StatelessWidget {
  const FrasesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FrasesApp',
      debugShowCheckedModeBanner: false,
      home: Scaffold(appBar: AppBar(title: const Text('FrasesApp'))),
    );
  }
}
