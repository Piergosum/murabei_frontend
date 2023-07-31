import 'package:flutter/material.dart';

import '../../storage/models/author.dart';
import 'controller/books_list_by_author_screen_controller.dart';

class BooksListByAuthorScreen extends StatefulWidget {
  const BooksListByAuthorScreen({super.key});

  @override
  State<BooksListByAuthorScreen> createState() => _BooksListByAuthorScreen();
}

class _BooksListByAuthorScreen extends State<BooksListByAuthorScreen> {
  late BooksListByAuthorScreenController _booksListByAuthorScreenController;

  Widget loadBooks() {
    return ValueListenableBuilder(
      valueListenable: _booksListByAuthorScreenController.booksLoading,
      builder: (context, value, child) {
        if (value) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        } else {
          if (_booksListByAuthorScreenController.booksList.isEmpty) {
            return const Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                  ),
                  Text(
                    'Nenhum livro registrado',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _booksListByAuthorScreenController.booksList.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 0,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/detalhes-livro',
                              arguments: _booksListByAuthorScreenController
                                  .booksList[index].id);
                        },
                        child: SizedBox(
                          height: 50,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              _booksListByAuthorScreenController
                                  .booksList[index].title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
              ),
            );
          }
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _booksListByAuthorScreenController = BooksListByAuthorScreenController();
  }

  @override
  void dispose() {
    super.dispose();
    _booksListByAuthorScreenController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(180),
        child: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 180,
          backgroundColor: Colors.black,
          title: Row(
            children: [
              Hero(
                tag: 'murabei logo',
                child: Image.asset(
                  'images/murabei-centered.png',
                  fit: BoxFit.cover,
                  height: 180,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Row(
          children: [
            const Expanded(child: SizedBox()),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 30),
                child: Column(
                  children: [
                    const Text(
                      'LISTAGEM DE LIVROS POR AUTOR',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    FutureBuilder(
                      future: _booksListByAuthorScreenController
                          .requestAuthorsList(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          );
                        } else {
                          if (_booksListByAuthorScreenController
                              .authorsList.isNotEmpty) {
                            return ValueListenableBuilder(
                              valueListenable:
                                  _booksListByAuthorScreenController
                                      .currentAuthorDropdown,
                              builder: (context, value, child) {
                                return Column(
                                  children: [
                                    const Text(
                                      'Escolha um autor:',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    DropdownButton<Author>(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      value: _booksListByAuthorScreenController
                                          .currentAuthorDropdown.value,
                                      onChanged: (Author? value) {
                                        _booksListByAuthorScreenController
                                            .changeAuthorDropdown(value!);
                                      },
                                      items: _booksListByAuthorScreenController
                                          .authorsList
                                          .map((Author value) {
                                        return DropdownMenuItem<Author>(
                                          value: value,
                                          child: Text(
                                            value.title,
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    loadBooks()
                                  ],
                                );
                              },
                            );
                          } else {
                            return const Center(
                              child: Text('Nenhum autor cadastrado'),
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
