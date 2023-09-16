import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_course_learning/models/chat_message_entity.dart';
import 'package:flutter_course_learning/services/auth_service.dart';
import 'package:flutter_course_learning/widgets/network_image_picker_body.dart';
import 'package:provider/provider.dart';

class ChatInput extends StatefulWidget {
  final void Function(ChatMessageEntity entity) onMessageSent;


  ChatInput({Key? key, required this.onMessageSent}):super(key: key);

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final _chatMessageController = TextEditingController();
  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          )),
      child: Container(
        constraints: BoxConstraints(minHeight: 70),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  showModalBottomSheet(context: context, builder: (context) {
                    return NetworkImagePickerBody(onImageSelected: onImagePicked,);
                  });
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                )),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _chatMessageController,
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              minLines: 1,
              style: TextStyle(
                    color: Colors.white,
              ),
              //textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter message...',
                      hintStyle: TextStyle(color: Colors.blueGrey)),
            ),
                   if(imageUrl.isNotEmpty) Image.network(imageUrl,height: 50,)
                  ],
                )),
            IconButton(
                onPressed: () async{
                  String userNameFromCache = await context.read<AuthService>().getUserName();
                  widget.onMessageSent.call(
                    ChatMessageEntity(text: _chatMessageController.value.text,createdAt: DateTime.now().millisecondsSinceEpoch, id: '13245', author: Author(userName: userNameFromCache),imageUrl: imageUrl.isNotEmpty? imageUrl : null)
                  );

                  imageUrl = '';
                  _chatMessageController.clear();
                  setState(() {

                  });
                },
                icon: Icon(
                  Icons.send,
                  color: Colors.white,
                ))
          ],
        ),
      ),
    );
  }

  void onImagePicked(String path){
    setState(() {
      imageUrl = path;
    });
    Navigator.of(context).pop();
  }
}
