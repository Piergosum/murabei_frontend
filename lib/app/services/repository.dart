import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:murabei_frontend/app/services/http_client.dart';
import 'package:murabei_frontend/app/storage/config.dart';
import 'package:murabei_frontend/app/storage/models/book.dart';
import 'package:http/http.dart' as http;

class Repository {
  final String _url = Config.apiUrl;
  String? _errorMessageDescription;
  Response? _requestResponse;
  static String _token = '';

  dynamic _httpResponse;

  final CustomHttpClient _customHttpClient = CustomHttpClient(
    client: Dio(
      BaseOptions(connectTimeout: 8000, receiveTimeout: 8000, headers: {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $_token"
      }),
    ),
  );

  Response? get requestResponse => _requestResponse;
  String? get errorMessageDescription => _errorMessageDescription;
  dynamic get httpResponse => _httpResponse;

  Future<String> requestGet(
      {required String? endPoint,
      Map<String, dynamic>? queryParameters}) async {
    try {
      Response response = await _customHttpClient.client
          .get(_url + endPoint!, queryParameters: queryParameters!);
      _requestResponse = response;
      return 'success';
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.sendTimeout) {
        _errorMessageDescription = 'Conexão indisponível';
        return 'no connection';
      } else {
        _errorMessageDescription = json.encode(e.response!.data['detail']);
        return 'Não foi possível realizar a operação. Tente novamente';
      }
    }
  }

  Future<String> requestPost({required String? endPoint, dynamic data}) async {
    try {
      Response response =
          await _customHttpClient.client.post(_url + endPoint!, data: data!);
      _requestResponse = response;
      return 'success';
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.sendTimeout) {
        _errorMessageDescription = 'Conexão indisponível';
        return 'no connection';
      } else {
        _errorMessageDescription = json.encode(e.response!.data['detail']);
        return 'Não foi possível realizar a operação. Tente novamente';
      }
    }
  }

  Future<String> requestPut({required String? endPoint, dynamic data}) async {
    try {
      Response response =
          await _customHttpClient.client.put(_url + endPoint!, data: data!);
      _requestResponse = response;
      return 'success';
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.sendTimeout) {
        _errorMessageDescription = 'Conexão indisponível';
        return 'no connection';
      } else {
        _errorMessageDescription = json.encode(e.response!.data['detail']);
        return 'Não foi possível realizar a operação. Tente novamente';
      }
    }
  }

  Future<String> requestDelete(
      {required String? endPoint, dynamic data}) async {
    try {
      Response response =
          await _customHttpClient.client.delete(_url + endPoint!, data: data!);
      _requestResponse = response;
      return 'success';
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.sendTimeout) {
        _errorMessageDescription = 'Conexão indisponível';
        return 'no connection';
      } else {
        _errorMessageDescription = json.encode(e.response!.data['detail']);
        return 'Não foi possível realizar a operação. Tente novamente';
      }
    }
  }

  Future<String> requestAuth(String username, String password) async {
    String result = await requestPost(
        endPoint: 'auth/', data: {'username': username, 'password': password});
    if (result == 'success') {
      _token = _requestResponse!.data['access'];
    } //
    return result;
  }

  Future<String> registerBook(Book book) async {
    String result = await requestPost(endPoint: 'book/create/', data: {
      'title': book.title,
      'author_id': book.authorId,
      'title_slug': book.titleSlug,
      'price': book.price,
      'format': book.format,
      'publisher': book.publisher,
      'pubdate': book.pubDate,
      'edition': book.edition,
      'lexile': book.lexile,
      'pages': book.pages,
      'dimensions': book.dimensions,
      'overview': book.overview,
      'excerpt': book.excerpt,
      'synopsis': book.synopsis,
      'toc': book.toc,
      'editorial_reviews': book.editorialReviews,
    });

    return result;
  }

  Future<String> requestSubjectsList() async {
    String result =
        await requestGet(endPoint: 'subjects/', queryParameters: {}); //
    return result;
  }

  Future<String> requestBooksList() async {
    String result =
        await requestGet(endPoint: 'books/', queryParameters: {}); //
    return result;
  }

  Future<String> requestBooksBySubject(String id) async {
    String result = await requestGet(
        endPoint: 'books-by-subject/$id', queryParameters: {}); //
    return result;
  }

  Future<String> requestBooksByAuthor(String id) async {
    String result = await requestGet(
        endPoint: 'books-by-author/$id', queryParameters: {}); //
    return result;
  }

  Future<String> requestBook(String id) async {
    //String result = await requestGet(endPoint: 'book/$id/');
    final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/v1/book/$id/'),
        headers: {"Authorization": "Bearer $_token"});
    if (response.statusCode == 200) {
      _httpResponse = json.decode(utf8.decode(response.bodyBytes));
      return 'success';
    } else {
      _httpResponse = json.encode(response.body);
      return 'fail';
    }
  }

  Future<String> requestUpdateBook(Book book) async {
    String result = await requestPut(endPoint: 'book/${book.id}/', data: {
      'title': book.title,
      'author_id': book.authorId,
      'title_slug': book.titleSlug,
      'price': book.price,
      'format': book.format,
      'publisher': book.publisher,
      'pubdate': book.pubDate,
      'edition': book.edition,
      'lexile': book.lexile,
      'pages': book.pages,
      'dimensions': book.dimensions,
      'overview': book.overview,
      'excerpt': book.excerpt,
      'synopsis': book.synopsis,
      'toc': book.toc,
      'editorial_reviews': book.editorialReviews,
    });
    return result;
  }

  Future<String> requestDeleteBook(String id) async {
    String result = await requestDelete(endPoint: 'book/$id', data: {}); //
    return result;
  }

  Future<String> requestAuthorsList() async {
    String result =
        await requestGet(endPoint: 'authors/', queryParameters: {}); //
    return result;
  }

  /*Future<String> requestAuthorsList() async {
    //String result = await requestGet(endPoint: 'author/$id/',); //
    final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/v1/authors/'),
        headers: {"Authorization": "Bearer $_token"});
    if (response.statusCode == 200) {
      _httpResponse = json.decode(response.body);
      return 'success';
    } else {
      _httpResponse = json.encode(response.body);
      return 'fail';
    }
  }*/

  Future<String> requestAuthor(String id) async {
    //String result = await requestGet(endPoint: 'author/$id/',); //
    final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/v1/author/$id/'),
        headers: {"Authorization": "Bearer $_token"});
    if (response.statusCode == 200) {
      _httpResponse = json.decode(response.body);
      return 'success';
    } else {
      _httpResponse = json.encode(response.body);
      return 'fail';
    }
  }
}
