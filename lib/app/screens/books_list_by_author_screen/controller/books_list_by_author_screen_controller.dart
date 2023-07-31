import 'package:flutter/material.dart';
import 'package:murabei_frontend/app/services/repository.dart';
import 'package:murabei_frontend/app/storage/models/author.dart';
import 'package:murabei_frontend/app/storage/models/book.dart';

class BooksListByAuthorScreenController extends ChangeNotifier {
  final ValueNotifier<Author?> _currentAuthorDropdown = ValueNotifier(null);
  final ValueNotifier<bool> _booksLoading = ValueNotifier(false);
  String _repositoryResponseMessage = '';

  final Repository _repository = Repository();

  final List<Author> _authorsList = [];

  final List<Book> _booksList = [];

  ValueNotifier<Author?> get currentAuthorDropdown => _currentAuthorDropdown;

  ValueNotifier<bool> get booksLoading => _booksLoading;

  String get repositoryResponseMessage => _repositoryResponseMessage;

  List<Book> get booksList => _booksList;

  List<Author> get authorsList => _authorsList;

  Future<String> changeAuthorDropdown(Author author) async {
    _currentAuthorDropdown.value = author;
    _booksLoading.value = true;
    String request = await requestBooksByAuthor(author.id!);
    if (request == 'success') {
      _booksLoading.value = false;
      return 'success';
    } else {
      _booksLoading.value = false;
      return 'fail';
    }
  }

  Future<String> requestAuthorsList() async {
    String request = await _repository.requestAuthorsList();
    if (request == 'success') {
      List<dynamic> subjecMaptList = _repository.requestResponse!.data;
      for (dynamic author in subjecMaptList) {
        _authorsList.add(
          Author.fromJson(author),
        );
      }
      return 'success';
    } else {
      _repositoryResponseMessage = _repository.errorMessageDescription!;
      return 'fail';
    }
  }

  Future<String> requestBooksByAuthor(String authorId) async {
    String request = await _repository.requestBooksByAuthor(authorId);
    if (request == 'success') {
      List<dynamic> authorMapList = _repository.requestResponse!.data;
      booksList.clear();
      for (dynamic book in authorMapList) {
        _booksList.add(
          Book.fromJson(book),
        );
      }
      return 'success';
    } else {
      _repositoryResponseMessage = _repository.errorMessageDescription!;
      return 'fail';
    }
  }

  Future<String> requestBooksList() async {
    String request = await _repository.requestBooksList();
    if (request == 'success') {
      List<dynamic> bookMapList = _repository.requestResponse!.data;
      for (dynamic book in bookMapList) {
        _booksList.add(
          Book.fromJson(book),
        );
      }
      return 'success';
    } else {
      _repositoryResponseMessage = _repository.errorMessageDescription!;
      return 'fail';
    }
  }
}
