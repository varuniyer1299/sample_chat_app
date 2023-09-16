import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_course_learning/models/image_model.dart';

class ImageRepository {
  Future<List<ImageModel>> getNetworkImages() async {
    try{
    final endPointUrl = Uri.parse('https://pixelford.com/api2/images');
    final response = await http.get(endPointUrl);

    if(response.statusCode == 200) {
      final List<dynamic> decodedList = jsonDecode(response.body);
      final List<ImageModel> images =
      decodedList.map((e) => ImageModel.fromJson(e)).toList();
      return images;
    }else{
      throw Exception('API not successful');
    }
    } on SocketException{
      throw Exception('socket exception');
    } on HttpException {
      throw Exception('http exception');
    }
    on FormatException{
      throw Exception('Format exception');
    }
    catch(e) {
      print(e);
      throw('Unknown error');
    }
  }
}
