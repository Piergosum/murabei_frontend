import 'package:flutter/material.dart';
import 'package:murabei_frontend/app/storage/models/subject.dart';

import 'controller/books_list_by_subject_screen_controller.dart';

class BooksListBySubjectScreen extends StatefulWidget {
  const BooksListBySubjectScreen({super.key});

  @override
  State<BooksListBySubjectScreen> createState() => _BooksListBySubjectScreen();
}

class _BooksListBySubjectScreen extends State<BooksListBySubjectScreen> {
  late BooksListBySubjectScreenController _booksListBySubjectsScreenController;

  @override
  void initState() {
    super.initState();
    _booksListBySubjectsScreenController = BooksListBySubjectScreenController();
  }

  @override
  void dispose() {
    super.dispose();
    _booksListBySubjectsScreenController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget loadBooks() {
      return ValueListenableBuilder(
        valueListenable: _booksListBySubjectsScreenController.booksLoading,
        builder: (context, value, child) {
          if (value) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          } else {
            if (_booksListBySubjectsScreenController.booksList.isEmpty) {
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
                  itemCount:
                      _booksListBySubjectsScreenController.booksList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 0,
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/detalhes-livro',
                                arguments: _booksListBySubjectsScreenController
                                    .booksList[index].id);
                          },
                          child: SizedBox(
                            height: 50,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                _booksListBySubjectsScreenController
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
                      'LISTAGEM DE LIVROS POR TEMA',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    FutureBuilder(
                      future: _booksListBySubjectsScreenController
                          .requestSubjectsList(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          );
                        } else {
                          if (_booksListBySubjectsScreenController
                              .subjectList.isNotEmpty) {
                            return ValueListenableBuilder(
                              valueListenable:
                                  _booksListBySubjectsScreenController
                                      .currentSubjectDropdown,
                              builder: (context, value, child) {
                                return Column(
                                  children: [
                                    const Text(
                                      'Escolha um tema:',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    DropdownButton<Subject>(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      value:
                                          _booksListBySubjectsScreenController
                                              .currentSubjectDropdown.value,
                                      onChanged: (value) {
                                        _booksListBySubjectsScreenController
                                            .changeSubjectDropdown(value!);
                                      },
                                      items:
                                          _booksListBySubjectsScreenController
                                              .subjectList
                                              .map((Subject value) {
                                        return DropdownMenuItem<Subject>(
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
                              child: Text('Nenhum tema cadastrado'),
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
