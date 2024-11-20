import 'package:flutter/material.dart';
import 'api_service.dart';
import 'package:google_fonts/google_fonts.dart'; // Add this to your dependencies

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  final ApiService _apiService = ApiService(); // Create an instance of ApiService


  void _sendMessage() async {
    String userMessage = _controller.text.trim();
    if (userMessage.isEmpty) return;

    setState(() {
      _messages.add({"role": "user", "content": userMessage});
    });

    _controller.clear();

    // Call the correct API method
    String response = await _apiService.sendMessageToGroqAPI(userMessage);

    setState(() {
      _messages.add({"role": "assistant", "content": response});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F1E2), // Set background color
      appBar: AppBar(
        centerTitle: true, // Center align title
        title: Text(
          'Chat Bot AI',
          style: GoogleFonts.roboto(
            color: Color(0xFFA679AD),
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xFFA679AD)),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message["role"] == "user";
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: isUser
                          ? MediaQuery.of(context).size.width * 0.6 // 60% for user
                          : MediaQuery.of(context).size.width * 0.75, // 75% for bot
                    ),
                    padding: EdgeInsets.all(12.0),
                    margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                    decoration: BoxDecoration(
                      color: isUser
                          ? Colors.white
                          : Color(0xFFA679AD), // Bot response color
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0),
                        bottomLeft:
                        isUser ? Radius.circular(8.0) : Radius.circular(0.0),
                        bottomRight:
                        isUser ? Radius.circular(0.0) : Radius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      message["content"] ?? '',
                      style: TextStyle(
                        color: isUser
                            ? Color(0xFFA679AD) // User message color
                            : Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: TextStyle(color: Color(0xFFA679AD)), // Text field text
                    decoration: InputDecoration(
                      hintText: 'Enter your message...',
                      hintStyle: TextStyle(color: Color(0xFFA679AD)), // Hint text
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Color(0xFFA679AD)), // Send button color
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}