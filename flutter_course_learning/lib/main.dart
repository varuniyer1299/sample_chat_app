import 'package:flutter/material.dart';
import 'package:flutter_course_learning/chat_page.dart';
import 'package:flutter_course_learning/login_page.dart';
import 'package:flutter_course_learning/services/auth_service.dart';
import 'package:flutter_course_learning/utils/brand_color.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthService.init();
  runApp(ChangeNotifierProvider(
    child: const ChatApp(),
    create: (context) => AuthService(),
  ));
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          canvasColor: Colors.transparent,
          primarySwatch: BrandColor.primaryColor,
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.transparent,
              iconTheme: IconThemeData(color: Colors.black))),
      home: context.watch<AuthService>().isLoggedIn()
          ? ChatPage()
          : LoginPage(), //route will be '/'
      routes: {
        '/chat': (context) => ChatPage(),
        '/login': (context) => LoginPage(),
      },
    );
  }
}
