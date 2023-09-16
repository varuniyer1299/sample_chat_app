import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier{

  static init() async{
    _prefs = await SharedPreferences.getInstance();
  }

  static late final SharedPreferences _prefs ;

  void loginUser(String userName) {
    try {
      _prefs.setString('userName', userName);
    }catch(e){
      print(e.toString());
    }
  }

 void logoutUser() {
    try {
      _prefs.clear();
    }catch(e){
      print(e.toString());
    }
  }

  String getUserName(){
    try {
      return _prefs.getString('userName') ?? '';
    }catch(e){
      print(e.toString());
      throw Exception();
    }
  }

  void updateUserName(String newUserName){
    _prefs.setString('userName', newUserName);
    notifyListeners();
  }

  bool isLoggedIn(){
    final name = _prefs.getString('userName');
    return (name ?? '').isNotEmpty;
  }
}