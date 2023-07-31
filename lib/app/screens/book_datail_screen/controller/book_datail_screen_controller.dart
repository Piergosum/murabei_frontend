import 'package:flutter/material.dart';
import 'package:murabei_frontend/app/screens/form_validator.dart';
import 'package:murabei_frontend/app/services/repository.dart';
import 'package:murabei_frontend/app/storage/models/book.dart';

class BookDetailScreenController extends ChangeNotifier {
  //variável responsável por fazer o rebuild da tela com o Book pós término da chamada requestBookDetail
  final ValueNotifier<bool> _fetchBookDataLoading = ValueNotifier(false);

  //variável responsável por fazer o rebuild da tela com o formulário de edição pós o usuário clicar no botão editar
  //troca de valor sempre ao chamar enableEdit()
  final ValueNotifier<bool> _editEnabled = ValueNotifier(false);
  //variável responsável por fazer o rebuild do botão de salvar edição dependendo do estado (enviar e enviando)
  //troca de valor sempre ao chamar requestUpdateBook()
  final ValueNotifier<bool> _registerLoading = ValueNotifier(false);
  //variável responsável por fazer o rebuild do botão de salvar edição dependendo do estado (salvar e salvando)
  //troca de valor sempre ao chamar requesDeleteBook()
  final ValueNotifier<bool> _onDeleteBookLoading = ValueNotifier(false);

  //repositorio responável por todas as requisições da API
  final Repository _repository = Repository();

  //resposta das requisições
  dynamic _repositoryResponseMessage;

  //Book que será atualizado com os dados retornados da requisição requestBookDetail()
  Book? _book;

  //authorTitle que será atualizado com os dados retornados da requisição requestAuthor()
  String? _authorTitle;

  //classe responsável por validar o formulário de edição do Book
  final FormValidator _formValidator = FormValidator();

  //GETTERS que serão usados na screen
  Book get book => _book!;

  ValueNotifier<bool> get fetchBookDataLoading => _fetchBookDataLoading;

  ValueNotifier<bool> get editEnabled => _editEnabled;

  ValueNotifier<bool> get registerLoading => _registerLoading;

  ValueNotifier<bool> get onDeleteBookLoading => _onDeleteBookLoading;

  String get repositoryResponseMessage => _repositoryResponseMessage;

  FormValidator get formValidator => _formValidator;

  String? get authorTitle => _authorTitle;

  //RESPONSÁVEL POR REQUISITAR À API POR UM BOOK
  Future<String> requestBookDetail(String id) async {
    _fetchBookDataLoading.value = true;
    String requestOne = await _repository.requestBook(id);
    if (requestOne == 'success') {
      dynamic bookMap = _repository.httpResponse;
      _book = Book.fromJson(bookMap);
      String requestTwo = await requestAuthor(book.authorId);
      if (requestTwo == 'success') {
        _fetchBookDataLoading.value = false;
        return 'success';
      } else {
        _fetchBookDataLoading.value = false;
        return 'fail';
      }
    } else {
      _repositoryResponseMessage = _repository.errorMessageDescription!;
      _fetchBookDataLoading.value = false;
      return 'fail';
    }
  }

  //RESPONSÁVEL POR REQUISITAR À API POR UM AUTHOR (relacionado ao author_id do book)
  Future<String> requestAuthor(String id) async {
    String request = await _repository.requestAuthor(id);
    if (request == 'success') {
      dynamic authorMap = _repository.httpResponse;
      _authorTitle = authorMap['title'];
      return 'success';
    } else {
      _repositoryResponseMessage = _repository.errorMessageDescription!;
      _registerLoading.value = false;
      return 'fail';
    }
  }

  //RESPONSÁVEL POR ATUALIZAR A TELA QUANDO O USUÁRIO ESCOLHER EDITAR O BOOK
  void enableEdit() {
    _editEnabled.value = _editEnabled.value ? false : true;
  }

  //RESPONSÁVEL POR REQUISITAR À API QUE ATUALIZE O BOOK
  Future<String> requestUpdateBook(
      String id,
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
        id: id,
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
    String request = await _repository.requestUpdateBook(book);
    if (request == 'success') {
      _repositoryResponseMessage = 'Alteração realizada com sucesso!';
      _registerLoading.value = false;
      return 'success';
    } else {
      _repositoryResponseMessage = _repository.errorMessageDescription!;

      _registerLoading.value = false;
      return 'fail';
    }
  }

  //RESPONSÁVEL POR REQUISITAR À API QUE DELETE O BOOK
  Future<String> requestDeleteBook() async {
    _onDeleteBookLoading.value = true;
    String request = await _repository.requestDeleteBook(_book!.id!);
    if (request == 'success') {
      _onDeleteBookLoading.value = false;
      _repositoryResponseMessage = 'Livro deletado com sucesso!';
      return 'success';
    } else {
      _repositoryResponseMessage = _repository.errorMessageDescription!;
      _onDeleteBookLoading.value = false;
      return 'fail';
    }
  }
}
