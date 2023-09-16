import 'dart:convert';
import 'package:flutter_course_learning/models/image_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_course_learning/models/chat_message_entity.dart';
import 'package:flutter_course_learning/repo/image_repository.dart';
import 'package:flutter_course_learning/services/auth_service.dart';
import 'package:flutter_course_learning/widgets/chat_bubble_widget.dart';
import 'package:flutter_course_learning/widgets/chat_input.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  //final String username; //only needed for anonymous route
  //ChatPage({super.key,required this.username});
  ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final chatMessageController = TextEditingController();
  final ImageRepository _imageRepo = ImageRepository();
  List<ChatMessageEntity> _messages = [];
  String username = '';

  @override
  void initState() {
    _loadInitialMessages();
  }

  _loadInitialMessages() async {
    final response = await rootBundle.loadString('assets/mock_messages.json');
    final responseJson = await jsonDecode(response);
    setState(() {
      _messages = List<Map<String, dynamic>>.from(responseJson)
          .map((e) => ChatMessageEntity.fromJson(e))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Container(),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title:
             Text(
                'Hi ${context.watch<AuthService>().getUserName()}',
                style: TextStyle(color: Colors.black),
              ),
        actions: [   IconButton(
            onPressed: () {
              print('icon pressed');
              context.read<AuthService>().updateUserName('New name');
            },
            icon: Icon(
              Icons.logout,
              color: Colors.black,
            )),
          IconButton(
              onPressed: () {
                print('icon pressed');
                context.read<AuthService>().logoutUser();
                //Navigator.maybePop(context); if there is something before in the stack then does it
                Navigator.popAndPushNamed(
                    context, '/login'); //'/' is equivalent to the home page route
              },
              icon: Icon(
                Icons.logout,
                color: Colors.black,
              ))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: ListView.builder(
                  itemCount: _messages.length,
                  itemBuilder: (context, index) => ChatBubbleWidget(
                        alignment: _messages[index].author.userName ==
                                context.watch<AuthService>().getUserName()
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        entity: _messages[index],
                      )),
            ),
          ),
          ChatInput(onMessageSent: onMessageSent),
        ],
      ),
    );
  }

  void onMessageSent(ChatMessageEntity entity) {
    _messages.add(entity);
    setState(() {});
  }
}
