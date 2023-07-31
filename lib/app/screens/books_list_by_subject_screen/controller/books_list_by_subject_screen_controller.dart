import 'package:flutter/material.dart';
import 'package:murabei_frontend/app/services/repository.dart';
import 'package:murabei_frontend/app/storage/models/book.dart';
import 'package:murabei_frontend/app/storage/models/subject.dart';

class BooksListBySubjectScreenController extends ChangeNotifier {
  final ValueNotifier<Subject?> _currentSubjectDropdown = ValueNotifier(null);
  final ValueNotifier<bool> _booksLoading = ValueNotifier(false);
  String _repositoryResponseMessage = '';

  final Repository _repository = Repository();

  final List<Subject> _subjectList = [];

  final List<Book> _booksList = [];

  ValueNotifier<Subject?> get currentSubjectDropdown => _currentSubjectDropdown;

  String get repositoryResponseMessage => _repositoryResponseMessage;

  ValueNotifier<bool> get booksLoading => _booksLoading;

  List<Book> get booksList => _booksList;

  List<Subject> get subjectList => _subjectList;

  Future<String> changeSubjectDropdown(Subject subject) async {
    _currentSubjectDropdown.value = subject;
    _booksLoading.value = true;
    String request = await requestBooksBySubject(subject.id!);
    if (request == 'success') {
      _booksLoading.value = false;
      return 'success';
    } else {
      _booksLoading.value = false;
      return 'fail';
    }
  }

  Future<String> requestSubjectsList() async {
    String request = await _repository.requestSubjectsList();
    if (request == 'success') {
      List<dynamic> subjecMaptList = _repository.requestResponse!.data;
      for (dynamic subject in subjecMaptList) {
        _subjectList.add(
          Subject.fromJson(subject),
        );
      }
      return 'success';
    } else {
      _repositoryResponseMessage = _repository.errorMessageDescription!;
      return 'fail';
    }
  }

  Future<String> requestBooksBySubject(String subjectId) async {
    String request = await _repository.requestBooksBySubject(subjectId);
    if (request == 'success') {
      List<dynamic> bookMapList = _repository.requestResponse!.data;
      booksList.clear();
      for (dynamic book in bookMapList) {
        booksList.add(
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
