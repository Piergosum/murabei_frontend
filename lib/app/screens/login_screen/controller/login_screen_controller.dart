import 'package:flutter/material.dart';
import 'package:murabei_frontend/app/screens/form_validator.dart';
import 'package:murabei_frontend/app/services/repository.dart';

class LoginScreenController extends ChangeNotifier {
  final ValueNotifier<bool> _loginLoading = ValueNotifier(false);

  String _repositoryResponseMessage = '';

  final Repository _repository = Repository();

  final FormValidator _formValidator = FormValidator();

  ValueNotifier<bool> get loginLoading => _loginLoading;

  String get repositoryResponseMessage => _repositoryResponseMessage;

  FormValidator get formValidator => _formValidator;

  Future<String> requestAuth(String username, String password) async {
    _loginLoading.value = true;
    String request = await _repository.requestAuth(username, password);
    if (request == 'success') {
      _loginLoading.value = false;
      return 'success';
    } else {
      _loginLoading.value = false;
      _repositoryResponseMessage = _repository.errorMessageDescription!;
      return 'fail';
    }
  }
}
