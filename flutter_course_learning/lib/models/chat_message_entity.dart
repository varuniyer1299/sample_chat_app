class ChatMessageEntity {
  String? text;
  String? imageUrl;
  int createdAt;
  String id;
  Author author;

  factory ChatMessageEntity.fromJson(Map<String, dynamic> json) =>
      ChatMessageEntity(
        createdAt: json['createdAt'],
        id: json['id'],
        author: Author.fromJson(json['author']),
        imageUrl: json['imageUrl'],
        text: json['text'],
      );

  ChatMessageEntity({
    this.text,
    this.imageUrl,
    required this.createdAt,
    required this.id,
    required this.author,
  });
}

class Author {
  String userName;

  factory Author.fromJson(Map<String,dynamic> json)=> Author(userName: json['userName']);

  Author({required this.userName});
}
