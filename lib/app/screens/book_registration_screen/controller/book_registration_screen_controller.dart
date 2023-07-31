import 'package:flutter/material.dart';
import 'package:murabei_frontend/app/screens/form_validator.dart';
import 'package:murabei_frontend/app/services/repository.dart';
import 'package:murabei_frontend/app/storage/models/book.dart';

class BookRegistrationScreenController extends ChangeNotifier {
  final ValueNotifier<bool> _registerLoading = ValueNotifier(false);

  String _repositoryResponseMessage = '';

  final Repository _repository = Repository();

  final FormValidator _formValidator = FormValidator();

  ValueNotifier<bool> get registerLoading => _registerLoading;

  String get repositoryResponseMessage => _repositoryResponseMessage;

  FormValidator get formValidator => _formValidator;

  Future<String> registerBook(
      String title,
      String authorId,
      String titleSlug,
      String price,
      String format,
      String publisher,
      String pubDate,
      String edition,
      String lexile,
      String pages,
      String dimensions,
      String overview,
      String excerpt,
      String synopsis,
      String toc,
      String editorialReviews) async {
    _registerLoading.value = true;
    String convertedPubDate =
        '${pubDate.substring(6, 10)}-${pubDate.substring(3, 5)}-${pubDate.substring(0, 2)}';
    Book book = Book(
        title: title,
        authorId: authorId,
        titleSlug: titleSlug,
        price: price,
        format: format,
        publisher: publisher,
        pubDate: convertedPubDate,
        edition: edition,
        lexile: lexile,
        pages: pages,
        dimensions: dimensions,
        overview: overview,
        excerpt: excerpt,
        synopsis: synopsis,
        toc: toc,
        editorialReviews: editorialReviews);
    String request = await _repository.registerBook(book);
    if (request == 'success') {
      _repositoryResponseMessage = 'Livro cadastrado com sucesso!';
      _registerLoading.value = false;
      return 'success';
    } else {
      _repositoryResponseMessage = _repository.errorMessageDescription!;
      _registerLoading.value = false;
      return 'fail';
    }
  }
}
