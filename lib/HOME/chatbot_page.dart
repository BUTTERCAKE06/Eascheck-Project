import 'package:flutter/material.dart';

void main() => runApp(ChatbotApp());

class ChatbotApp extends StatelessWidget {
  const ChatbotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatbotPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  _ChatbotPageState createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = List<String>.empty(growable: true);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _sendMessage() {
    if (_controller.text.trim().isNotEmpty) {
      setState(() {
        _messages.add(_controller.text.trim());
        _controller.clear();
        _messages.add("ยังไม่ได้ทำ");
      });
    }
  }

  void _clearHistory() {
    setState(() {
      _messages.clear();
    });
    Navigator.of(context).pop(); // ปิด Drawer
  }

  List<String> get _userMessages {
    List<String> userMessages = [];
    for (int i = 0; i < _messages.length; i += 2) {
      userMessages.add(_messages[i]);
    }
    return userMessages;
  }

  Widget _buildMessage(String msg, bool isUser) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisAlignment:
        isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser)
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.teal,
              child: Icon(Icons.smart_toy, size: 16, color: Colors.white),
            ),
          if (!isUser) SizedBox(width: 8),
          Flexible(
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isUser ? Colors.teal.shade100 : Colors.grey.shade200,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomLeft:
                  isUser ? Radius.circular(16) : Radius.circular(0),
                  bottomRight:
                  isUser ? Radius.circular(0) : Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isUser ? "You:" : "Bot:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    msg,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          if (isUser) SizedBox(width: 8),
          if (isUser)
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.teal,
              child: Icon(Icons.person, size: 16, color: Colors.white),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: Row(
                children: [
                  Icon(Icons.list, size: 28, color: Colors.teal),
                  SizedBox(width: 8),
                  Text(
                    "ประวัติคำถามของคุณ",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _userMessages.isEmpty
                  ? Center(child: Text("ยังไม่มีคำถามที่ถาม"))
                  : ListView.builder(
                itemCount: _userMessages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading:
                    Icon(Icons.question_answer, color: Colors.teal),
                    title: Text(_userMessages[index]),
                    onTap: () {
                      Navigator.pop(context); // ปิด Drawer
                      setState(() {
                        _controller.text = _userMessages[index];
                      });
                    },
                  );
                },
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: ElevatedButton.icon(
                icon: Icon(Icons.delete),
                label: Text("ล้างประวัติคำถาม"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                ),
                onPressed: _userMessages.isEmpty ? null : _clearHistory,
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text(
          "Chatbot",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: Icon(Icons.drag_handle, color: Colors.black),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
      ),
      body: Column(
        children: [
          if (_messages.isEmpty)
            Expanded(
              child: Column(
                children: [
                  Spacer(),
                  _buildOptions(),
                ],
              ),
            ),
          if (_messages.isNotEmpty)
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ListView.builder(
                  reverse: true,
                  padding: EdgeInsets.all(8),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    int reversedIndex = _messages.length - 1 - index;
                    return _buildMessage(
                        _messages[reversedIndex], reversedIndex % 2 == 0);
                  },
                ),
              ),
            ),
          _buildInputField(),
        ],
      ),
    );
  }

  Widget _buildOptions() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 24),
        Text("How can I assist you today?", style: TextStyle(fontSize: 18)),
        SizedBox(height: 12),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 16,
          runSpacing: 12,
          children: [
            _buildOption("Meal Plan Summary", Icons.restaurant_menu),
            _buildOption("Health Tips", Icons.favorite),
            _buildOption("Workout Suggestions", Icons.fitness_center),
            _buildOption("Ask a Question", Icons.question_answer),
          ],
        ),
        SizedBox(height: 24),
      ],
    );
  }

  Widget _buildOption(String title, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 28, color: Colors.teal),
        SizedBox(height: 4),
        Text(title, style: TextStyle(fontSize: 14)),
      ],
    );
  }

  Widget _buildInputField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "พิมพ์คำถามของคุณ...",
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: Colors.teal),
            onPressed: _sendMessage,
          )
        ],
      ),
    );
  }
}
