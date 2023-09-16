import 'package:flutter/material.dart';
import 'package:flutter_course_learning/models/chat_message_entity.dart';
import 'package:flutter_course_learning/services/auth_service.dart';
import 'package:provider/provider.dart';

class ChatBubbleWidget extends StatelessWidget {
  final ChatMessageEntity entity;
  final Alignment alignment;

  const ChatBubbleWidget({
    super.key,
    required this.entity,
    required this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    bool isAuthor = entity.author.userName == context.watch<AuthService>().getUserName();
    return Align(
      alignment: alignment,
      child: Container(
        constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width / 1.4, minWidth: 0),
        margin: EdgeInsets.only(bottom: 30),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isAuthor ? Theme.of(context).primaryColor : Colors.black,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (entity.text != null)
              Text(
                entity.text ?? '',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            if (entity.imageUrl != null)
              Container(
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image:
                        DecorationImage(image: NetworkImage(entity.imageUrl!),fit: BoxFit.fitWidth)),
              ),
          ],
        ),
      ),
    );
  }
}
