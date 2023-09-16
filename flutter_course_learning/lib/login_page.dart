import 'package:flutter/material.dart';
import 'package:flutter_course_learning/services/auth_service.dart';
import 'package:flutter_course_learning/widgets/login_text_field.dart';
import 'package:provider/provider.dart';
import 'package:social_media_buttons/social_media_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Text(
          'Lets sign you in',
          style: TextStyle(
            color: Colors.pinkAccent,
            fontSize: 20,
          ),
        ),
        Text(
          'Welcome back!\nYou\'ve been missed',
          style: TextStyle(color: Colors.blueAccent),
          textAlign: TextAlign.center,
        ),
        Image.network(
            'https://cdn.photographylife.com/wp-content/uploads/2014/09/Nikon-D750-Image-Samples-2.jpg'),
      ],
    );
  }

  Widget _buildForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: LoginTextField(
                    validator: (value) {
                      if ((value ?? '').isEmpty) {
                        return "Username should not be empty";
                      } else if (value!.length < 5) {
                        return "Username should contain more than 5 characters";
                      }
                    },
                    hintText: 'Please provide username',
                    controller: usernameController,
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: LoginTextField(
                  hintText: 'Please provide password',
                  controller: passwordController,
                  validator: (value) {},
                  isObscured: true,
                ),
              )
            ],
          ),
        ),
        ElevatedButton(
            onPressed: () {
              loginUser(context);
            },
            child: Text('Login')),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          child: Text('Learn more'),
          onTap: () async {
            print('link clicked');
            await launchUrlString('https://google.com');
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SocialMediaButton.facebook(
              url: 'https://facebook.com',
            ),
            SocialMediaButton.instagram(url: 'https://instagram.com'),
            SocialMediaButton.twitter(url: 'https://twitter.com'),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 1000) {
          //for web
          return Row(
            children: [
              Spacer(flex: 1),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [_buildHeader(context), _buildFooter(context)],
                ),
              ),
              Spacer(flex: 1),
              Expanded(child: _buildForm(context)),
              Spacer(flex: 1),
            ],
          );
        }
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildHeader(context),
                  _buildForm(context),
                  _buildFooter(context),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  void loginUser(BuildContext context) {
    if (!(_formKey.currentState?.validate() ?? false)) {
      //throw error
    }

    //Anonymous route
    // Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatPage(username: usernameController.text,)));

    context.read<AuthService>().loginUser(usernameController.text);
    //Named route
    Navigator.pushReplacementNamed(
      context,
      '/chat',
    ); //Refer to routes argument in main.dart
  }
}
