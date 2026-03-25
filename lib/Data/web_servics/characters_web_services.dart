import 'package:dio/dio.dart';
import 'package:flutter_breaking/constants/strings.dart';

class CharactersWebService {
  late Dio dio;

  CharactersWebService() {
    BaseOptions options = BaseOptions(
      baseUrl: baseurl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    );

    dio = Dio(options);
  }

  Future<List<dynamic>> getAllCharacters() async {
    try {
      Response response = await dio.get('/character');

      // response.data => Map كبير
      // response.data['results'] => List جاية من السيرفر
      return response.data['results'];
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<dynamic>> getCharacterQuotes(String charName) async {
    try {
      Response response = await dio.get(
        'https://catfact.ninja/facts',
        queryParameters: {'limit': 10},
      );

      print('Response data: ${response.data}');

      // الـ API بترجع List من الـ facts
      if (response.data is Map && response.data['data'] != null) {
        return response.data['data'];
      } else if (response.data is List) {
        return response.data;
      }

      return [];
    } catch (e) {
      print('Error: ${e.toString()}');
      return [];
    }
  }
}
