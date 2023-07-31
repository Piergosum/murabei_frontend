import 'package:flutter/material.dart';
import 'package:murabei_frontend/app/screens/book_datail_screen/book_datail_screen.dart';
import 'package:murabei_frontend/app/screens/book_registration_screen/book_registration_screen.dart.dart';
import 'package:murabei_frontend/app/screens/books_list_by_author_screen/books_list_by_author_screen.dart';
import 'package:murabei_frontend/app/screens/books_list_by_subject_screen/books_list_by_subject_screen.dart';
import 'package:murabei_frontend/app/screens/initial_screen/initial_screen.dart';
import 'package:murabei_frontend/app/screens/login_screen/login_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> routes = {
    '/login': (_) => const LoginScreen(),
    '/pagina-inicial': (_) => const InitialScreen(),
    '/cadastrar-livro': (_) => const BookRegistrationScreen(),
    '/listagem-livros-tema': (_) => const BooksListBySubjectScreen(),
    '/listagem-livros-author': (_) => const BooksListByAuthorScreen(),
    '/detalhes-livro': (_) => const BookDataScreen(),
    //'/quem-somos': (_) => const AboutPratexScreen(),
  };
}
