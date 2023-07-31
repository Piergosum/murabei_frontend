import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:murabei_frontend/app/screens/login_screen/widgets/custom_text_form_field.dart';

import '../shared_widgets/response_popup.dart';
import 'controller/book_datail_screen_controller.dart';

class BookDataScreen extends StatelessWidget {
  const BookDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BookDetailScreenController bookDetailScreenController =
        BookDetailScreenController();
    final String id = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(180),
        child: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 180,
          backgroundColor: Colors.black,
          title: Hero(
            tag: 'murabei logo',
            child: Image.asset(
              'images/murabei-centered.png',
              fit: BoxFit.cover,
              height: 180,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Row(
          children: [
            const Expanded(child: SizedBox()),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 60),
                child: Column(
                  children: [
                    const Text(
                      'DETALHES DO LIVRO',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Column(
                      children: [
                        FutureBuilder(
                          future:
                              bookDetailScreenController.requestBookDetail(id),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                ),
                              );
                            } else {
                              if (snapshot.data == 'success') {
                                return BookDataView(
                                  bookDetailScreenController:
                                      bookDetailScreenController,
                                );
                              } else {
                                return const Center(
                                  child: Text(
                                      'Não foi possível carregar os dados. Tente novamente'),
                                );
                              }
                            }
                          },
                        ),
                      ],
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

class BookDataView extends StatefulWidget {
  const BookDataView({super.key, required this.bookDetailScreenController});

  final BookDetailScreenController bookDetailScreenController;

  @override
  State<BookDataView> createState() => _BookDataView();
}

class _BookDataView extends State<BookDataView> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _authorIdController = TextEditingController();
  TextEditingController _titleSlugController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _formatController = TextEditingController();
  TextEditingController _publisherController = TextEditingController();
  TextEditingController _pubdateController = TextEditingController();
  TextEditingController _editionController = TextEditingController();
  TextEditingController _lexileController = TextEditingController();
  TextEditingController _pagesController = TextEditingController();
  TextEditingController _dimensionsController = TextEditingController();
  TextEditingController _overviewController = TextEditingController();
  TextEditingController _excerptController = TextEditingController();
  TextEditingController _synopsisController = TextEditingController();
  TextEditingController _tocController = TextEditingController();
  TextEditingController _editorialReviewsController = TextEditingController();
  final _registerBookFormKey = GlobalKey<FormState>();
  final ResponsePopup _responsePopup = ResponsePopup();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
        text: widget.bookDetailScreenController.book.title);
    _authorIdController = TextEditingController(
        text: widget.bookDetailScreenController.book.authorId);
    _titleSlugController = TextEditingController(
        text: widget.bookDetailScreenController.book.titleSlug);
    _priceController = TextEditingController(
        text: widget.bookDetailScreenController.book.price);
    _formatController = TextEditingController(
        text: widget.bookDetailScreenController.book.format);
    _publisherController = TextEditingController(
        text: widget.bookDetailScreenController.book.publisher);
    _pubdateController = TextEditingController(
        text: widget.bookDetailScreenController.book.pubDate);
    _editionController = TextEditingController(
        text: widget.bookDetailScreenController.book.edition);
    _lexileController = TextEditingController(
        text: widget.bookDetailScreenController.book.lexile);
    _pagesController = TextEditingController(
        text: widget.bookDetailScreenController.book.pages);
    _dimensionsController = TextEditingController(
        text: widget.bookDetailScreenController.book.dimensions);
    _overviewController = TextEditingController(
        text: widget.bookDetailScreenController.book.overview);
    _excerptController = TextEditingController(
        text: widget.bookDetailScreenController.book.excerpt);
    _synopsisController = TextEditingController(
        text: widget.bookDetailScreenController.book.synopsis);
    _tocController =
        TextEditingController(text: widget.bookDetailScreenController.book.toc);
    _editorialReviewsController = TextEditingController(
        text: widget.bookDetailScreenController.book.editorialReviews);
  }

  @override
  void dispose() {
    super.dispose();
    widget.bookDetailScreenController.dispose();
    _titleController.dispose();
    _authorIdController.dispose();
    _titleSlugController.dispose();
    _priceController.dispose();
    _formatController.dispose();
    _publisherController.dispose();
    _pubdateController.dispose();
    _editionController.dispose();
    _lexileController.dispose();
    _pagesController.dispose();
    _dimensionsController.dispose();
    _overviewController.dispose();
    _excerptController.dispose();
    _synopsisController.dispose();
    _tocController.dispose();
    _editorialReviewsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<BookListTileData> bookListTileDataList = [
      BookListTileData(
          title: 'Título',
          subtitle: widget.bookDetailScreenController.book.title),
      BookListTileData(
          title: 'Autor',
          subtitle: widget.bookDetailScreenController.authorTitle),
      BookListTileData(
          title: 'Title Slug',
          subtitle: widget.bookDetailScreenController.book.titleSlug),
      BookListTileData(
          title: 'Preço',
          subtitle: widget.bookDetailScreenController.book.price),
      BookListTileData(
          title: 'Formato',
          subtitle: widget.bookDetailScreenController.book.format),
      BookListTileData(
          title: 'Editora',
          subtitle: widget.bookDetailScreenController.book.publisher),
      BookListTileData(
          title: 'Data de Publicação',
          subtitle: widget.bookDetailScreenController.book.pubDate),
      BookListTileData(
          title: 'Edição',
          subtitle: widget.bookDetailScreenController.book.edition),
      BookListTileData(
          title: 'Lexile',
          subtitle: widget.bookDetailScreenController.book.lexile),
      BookListTileData(
          title: 'Páginas',
          subtitle: widget.bookDetailScreenController.book.pages),
      BookListTileData(
          title: 'Dimensões',
          subtitle: widget.bookDetailScreenController.book.dimensions),
      BookListTileData(
          title: 'Overview',
          subtitle: widget.bookDetailScreenController.book.overview),
      BookListTileData(
          title: 'Excerpt',
          subtitle: widget.bookDetailScreenController.book.excerpt),
      BookListTileData(
          title: 'Sinopse',
          subtitle: widget.bookDetailScreenController.book.synopsis),
      BookListTileData(
          title: 'Toc', subtitle: widget.bookDetailScreenController.book.title),
      BookListTileData(
          title: 'Review Editorial',
          subtitle: widget.bookDetailScreenController.book.title),
    ];
    return ValueListenableBuilder(
      valueListenable: widget.bookDetailScreenController.editEnabled,
      builder: (context, value, child) {
        if (!value) {
          return Column(
            children: [
              Column(
                children: bookListTileDataList
                    .map(
                      (e) => ListTile(
                        title: Text(
                          e.title!,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        subtitle: Text(
                          e.subtitle!,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    )
                    .toList(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            backgroundColor:
                                const Color.fromRGBO(225, 23, 106, 1),
                          ),
                          onPressed: () async {
                            widget.bookDetailScreenController.enableEdit();
                          },
                          child: const Text(
                            'Editar',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            backgroundColor:
                                const Color.fromRGBO(225, 23, 106, 1),
                          ),
                          onPressed: () async {
                            return showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.only(
                                      top: 5, right: 10, left: 10, bottom: 20),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      const Text(
                                        'Tem certeza que deseja deletar o livro?',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      const SizedBox(
                                        height: 32,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: SizedBox(
                                              height: 50,
                                              child: ValueListenableBuilder(
                                                valueListenable: widget
                                                    .bookDetailScreenController
                                                    .onDeleteBookLoading,
                                                builder:
                                                    (context, value, child) {
                                                  return ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                      ),
                                                      backgroundColor:
                                                          const Color.fromRGBO(
                                                              225, 23, 106, 1),
                                                    ),
                                                    onPressed: () async {
                                                      String request = await widget
                                                          .bookDetailScreenController
                                                          .requestDeleteBook();
                                                      if (request ==
                                                          'success') {
                                                        if (context.mounted) {
                                                          Navigator
                                                              .popAndPushNamed(
                                                            context,
                                                            '/pagina-inicial',
                                                          );
                                                          _responsePopup.showPopup(
                                                              context,
                                                              widget
                                                                  .bookDetailScreenController
                                                                  .repositoryResponseMessage,
                                                              request);
                                                        }
                                                      } else {
                                                        if (context.mounted) {
                                                          return _responsePopup
                                                              .showPopup(
                                                                  context,
                                                                  widget
                                                                      .bookDetailScreenController
                                                                      .repositoryResponseMessage,
                                                                  request);
                                                        }
                                                      }
                                                    },
                                                    child: value
                                                        ? const Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          )
                                                        : const Text(
                                                            'Sim',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          const Expanded(
                                            child: SizedBox(),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: SizedBox(
                                              height: 50,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                  backgroundColor:
                                                      const Color.fromRGBO(
                                                          225, 23, 106, 1),
                                                ),
                                                onPressed: () async {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  'Não',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: const Text(
                            'Deletar',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return Column(
            children: [
              Form(
                key: _registerBookFormKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      theme: 'dark',
                      label: 'Título',
                      controller: _titleController,
                      validator: widget
                          .bookDetailScreenController.formValidator.validate,
                      inputFormatters: const [],
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextFormField(
                      theme: 'dark',
                      label: 'ID do autor',
                      controller: _authorIdController,
                      validator: widget
                          .bookDetailScreenController.formValidator.validate,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextFormField(
                      theme: 'dark',
                      label: 'Title Slug',
                      controller: _titleSlugController,
                      validator: widget
                          .bookDetailScreenController.formValidator.validate,
                      inputFormatters: const [],
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextFormField(
                      theme: 'dark',
                      label: 'Data de Publicação',
                      controller: _pubdateController,
                      validator: widget
                          .bookDetailScreenController.formValidator.validate,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        DataInputFormatter(),
                      ],
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextFormField(
                      theme: 'dark',
                      label: 'Páginas',
                      controller: _pagesController,
                      validator: widget
                          .bookDetailScreenController.formValidator.validate,
                      inputFormatters: const [],
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextFormField(
                      theme: 'dark',
                      label: 'Preço',
                      controller: _priceController,
                      validator: widget
                          .bookDetailScreenController.formValidator.validate,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        RealInputFormatter()
                      ],
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextFormField(
                      theme: 'dark',
                      label: 'Formato',
                      controller: _formatController,
                      validator: widget
                          .bookDetailScreenController.formValidator.validate,
                      inputFormatters: const [],
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextFormField(
                      theme: 'dark',
                      label: 'Editora',
                      controller: _publisherController,
                      validator: widget
                          .bookDetailScreenController.formValidator.validate,
                      inputFormatters: const [],
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextFormField(
                      theme: 'dark',
                      label: 'Edição',
                      controller: _editionController,
                      validator: widget
                          .bookDetailScreenController.formValidator.validate,
                      inputFormatters: const [],
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextFormField(
                      theme: 'dark',
                      label: 'Dimensões',
                      controller: _dimensionsController,
                      validator: widget
                          .bookDetailScreenController.formValidator.validate,
                      inputFormatters: const [],
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextFormField(
                      theme: 'dark',
                      label: 'Lexile',
                      controller: _lexileController,
                      validator: widget
                          .bookDetailScreenController.formValidator.validate,
                      inputFormatters: const [],
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextFormField(
                      theme: 'dark',
                      label: 'Overview',
                      controller: _overviewController,
                      validator: widget
                          .bookDetailScreenController.formValidator.validate,
                      inputFormatters: const [],
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextFormField(
                      theme: 'dark',
                      label: 'Excerpt',
                      controller: _excerptController,
                      validator: widget
                          .bookDetailScreenController.formValidator.validate,
                      inputFormatters: const [],
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextFormField(
                      theme: 'dark',
                      label: 'Sinopse',
                      controller: _synopsisController,
                      validator: widget
                          .bookDetailScreenController.formValidator.validate,
                      inputFormatters: const [],
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextFormField(
                      theme: 'dark',
                      label: 'Toc',
                      controller: _tocController,
                      validator: widget
                          .bookDetailScreenController.formValidator.validate,
                      inputFormatters: const [],
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextFormField(
                      theme: 'dark',
                      label: 'Review Editorial',
                      controller: _editorialReviewsController,
                      validator: widget
                          .bookDetailScreenController.formValidator.validate,
                      inputFormatters: const [],
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ValueListenableBuilder(
                        valueListenable:
                            widget.bookDetailScreenController.registerLoading,
                        builder: (context, value, child) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              backgroundColor:
                                  const Color.fromRGBO(225, 23, 106, 1),
                            ),
                            onPressed: () async {
                              if (_registerBookFormKey.currentState!
                                  .validate()) {
                                if (widget.bookDetailScreenController.book
                                        .authorId !=
                                    _authorIdController.text) {
                                  if (context.mounted) {
                                    return showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(5),
                                            ),
                                          ),
                                          contentPadding: const EdgeInsets.only(
                                              top: 5,
                                              right: 10,
                                              left: 10,
                                              bottom: 20),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const SizedBox(
                                                height: 16,
                                              ),
                                              const Text(
                                                'Você está alterando o autor do livro. Deseja continuar?',
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              const SizedBox(
                                                height: 32,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: SizedBox(
                                                      height: 50,
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                          ),
                                                          backgroundColor:
                                                              const Color
                                                                      .fromRGBO(
                                                                  225,
                                                                  23,
                                                                  106,
                                                                  1),
                                                        ),
                                                        onPressed: () async {
                                                          String request = await widget.bookDetailScreenController.requestUpdateBook(
                                                              widget
                                                                  .bookDetailScreenController
                                                                  .book
                                                                  .id!,
                                                              _titleController
                                                                  .text,
                                                              _authorIdController
                                                                  .text,
                                                              _titleSlugController
                                                                  .text,
                                                              _priceController
                                                                  .text,
                                                              _formatController
                                                                  .text,
                                                              _publisherController
                                                                  .text,
                                                              _pubdateController
                                                                  .text,
                                                              _editionController
                                                                  .text,
                                                              _lexileController
                                                                  .text,
                                                              _pagesController
                                                                  .text,
                                                              _dimensionsController
                                                                  .text,
                                                              _overviewController
                                                                  .text,
                                                              _excerptController
                                                                  .text,
                                                              _synopsisController
                                                                  .text,
                                                              _tocController
                                                                  .text,
                                                              _editorialReviewsController
                                                                  .text);
                                                          if (context.mounted) {
                                                            Navigator.popAndPushNamed(
                                                                context,
                                                                '/detalhes-livro',
                                                                arguments: widget
                                                                    .bookDetailScreenController
                                                                    .book
                                                                    .id);
                                                            return _responsePopup
                                                                .showPopup(
                                                                    context,
                                                                    widget
                                                                        .bookDetailScreenController
                                                                        .repositoryResponseMessage,
                                                                    request);
                                                          }
                                                        },
                                                        child: const Text(
                                                          'Sim',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const Expanded(
                                                    child: SizedBox(),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: SizedBox(
                                                      height: 50,
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                          ),
                                                          backgroundColor:
                                                              const Color
                                                                      .fromRGBO(
                                                                  225,
                                                                  23,
                                                                  106,
                                                                  1),
                                                        ),
                                                        onPressed: () async {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                          'Não',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  }
                                }
                                String request = await widget
                                    .bookDetailScreenController
                                    .requestUpdateBook(
                                        widget.bookDetailScreenController.book
                                            .id!,
                                        _titleController.text,
                                        _authorIdController.text,
                                        _titleSlugController.text,
                                        _priceController.text,
                                        _formatController.text,
                                        _publisherController.text,
                                        _pubdateController.text,
                                        _editionController.text,
                                        _lexileController.text,
                                        _pagesController.text,
                                        _dimensionsController.text,
                                        _overviewController.text,
                                        _excerptController.text,
                                        _synopsisController.text,
                                        _tocController.text,
                                        _editorialReviewsController.text);

                                if (context.mounted) {
                                  Navigator.popAndPushNamed(
                                      context, '/detalhes-livro',
                                      arguments: widget
                                          .bookDetailScreenController.book.id);
                                  return _responsePopup.showPopup(
                                      context,
                                      widget.bookDetailScreenController
                                          .repositoryResponseMessage,
                                      request);
                                }
                              }
                            },
                            child: value
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text(
                                    'Salvar',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                          );
                        },
                      ),
                    ),
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          backgroundColor:
                              const Color.fromRGBO(225, 23, 106, 1),
                        ),
                        onPressed: () async {
                          widget.bookDetailScreenController.enableEdit();
                        },
                        child: const Text(
                          'Cancelar',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        }
      },
    );
  }
}

class BookListTileData {
  BookListTileData({required this.title, required this.subtitle});
  final String? title;
  final String? subtitle;
}
