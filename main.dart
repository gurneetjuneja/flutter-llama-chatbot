import 'package:flutter/material.dart';
import 'chat_screen.dart'; // Import the ChatScreen widget

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chatbot',
      theme: ThemeData(
        primaryColor: Color(0xFFA679AD), // Set the primary color
        // Optionally, you can also customize other aspects like button color, etc.
      ),
      home: ChatScreen(), // Set the home screen to ChatScreen
    );
  }
}
