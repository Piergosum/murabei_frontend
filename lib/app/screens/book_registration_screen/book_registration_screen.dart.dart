import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:murabei_frontend/app/screens/book_registration_screen/controller/book_registration_screen_controller.dart';
import 'package:murabei_frontend/app/screens/login_screen/widgets/custom_text_form_field.dart';
import 'package:murabei_frontend/app/screens/shared_widgets/response_popup.dart';

class BookRegistrationScreen extends StatefulWidget {
  const BookRegistrationScreen({super.key});

  @override
  State<BookRegistrationScreen> createState() => _BookRegistrationScreen();
}

class _BookRegistrationScreen extends State<BookRegistrationScreen> {
  late BookRegistrationScreenController _bookRegistrationScreenController;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorIdController = TextEditingController();
  final TextEditingController _titleSlugController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _formatController = TextEditingController();
  final TextEditingController _publisherController = TextEditingController();
  final TextEditingController _pubdateController = TextEditingController();
  final TextEditingController _editionController = TextEditingController();
  final TextEditingController _lexileController = TextEditingController();
  final TextEditingController _pagesController = TextEditingController();
  final TextEditingController _dimensionsController = TextEditingController();
  final TextEditingController _overviewController = TextEditingController();
  final TextEditingController _excerptController = TextEditingController();
  final TextEditingController _synopsisController = TextEditingController();
  final TextEditingController _tocController = TextEditingController();
  final TextEditingController _editorialReviewsController =
      TextEditingController();
  final _registerBookFormKey = GlobalKey<FormState>();
  final ResponsePopup _responsePopup = ResponsePopup();

  @override
  void initState() {
    super.initState();
    _bookRegistrationScreenController = BookRegistrationScreenController();
  }

  @override
  void dispose() {
    super.dispose();
    _bookRegistrationScreenController.dispose();
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
                padding: const EdgeInsets.only(top: 50, bottom: 50),
                child: Column(
                  children: [
                    const Text(
                      'CADASTRAR LIVRO',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Form(
                      key: _registerBookFormKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomTextFormField(
                              theme: 'dark',
                              label: 'Título',
                              controller: _titleController,
                              validator: _bookRegistrationScreenController
                                  .formValidator.validate,
                              keyboardType: TextInputType.text),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextFormField(
                              theme: 'dark',
                              label: 'ID do Autor',
                              controller: _authorIdController,
                              validator: _bookRegistrationScreenController
                                  .formValidator.validate,
                              keyboardType: TextInputType.number),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextFormField(
                              theme: 'dark',
                              label: 'Title Slug',
                              controller: _titleSlugController,
                              validator: _bookRegistrationScreenController
                                  .formValidator.validate,
                              keyboardType: TextInputType.text),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextFormField(
                              theme: 'dark',
                              label: 'Preço',
                              controller: _priceController,
                              validator: _bookRegistrationScreenController
                                  .formValidator.validate,
                              keyboardType: TextInputType.text),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextFormField(
                              theme: 'dark',
                              label: 'Formato',
                              controller: _formatController,
                              validator: _bookRegistrationScreenController
                                  .formValidator.validate,
                              keyboardType: TextInputType.text),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextFormField(
                              theme: 'dark',
                              label: 'Editora',
                              controller: _publisherController,
                              validator: _bookRegistrationScreenController
                                  .formValidator.validate,
                              keyboardType: TextInputType.text),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextFormField(
                              theme: 'dark',
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                DataInputFormatter()
                              ],
                              label: 'Data de publicação',
                              controller: _pubdateController,
                              validator: _bookRegistrationScreenController
                                  .formValidator.validate,
                              keyboardType: TextInputType.number),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextFormField(
                              theme: 'dark',
                              label: 'Edição',
                              controller: _editionController,
                              validator: _bookRegistrationScreenController
                                  .formValidator.validate,
                              keyboardType: TextInputType.text),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextFormField(
                              theme: 'dark',
                              label: 'Lexile',
                              controller: _lexileController,
                              validator: _bookRegistrationScreenController
                                  .formValidator.validate,
                              keyboardType: TextInputType.text),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextFormField(
                              theme: 'dark',
                              label: 'Páginas',
                              controller: _pagesController,
                              validator: _bookRegistrationScreenController
                                  .formValidator.validate,
                              keyboardType: TextInputType.number),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextFormField(
                              theme: 'dark',
                              label: 'Dimensões',
                              controller: _dimensionsController,
                              validator: _bookRegistrationScreenController
                                  .formValidator.validate,
                              keyboardType: TextInputType.text),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextFormField(
                              theme: 'dark',
                              label: 'Overview',
                              controller: _overviewController,
                              validator: _bookRegistrationScreenController
                                  .formValidator.validate,
                              keyboardType: TextInputType.text),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextFormField(
                              theme: 'dark',
                              label: 'Excerpts',
                              controller: _excerptController,
                              validator: _bookRegistrationScreenController
                                  .formValidator.validate,
                              keyboardType: TextInputType.text),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextFormField(
                              theme: 'dark',
                              label: 'Sinopse',
                              controller: _synopsisController,
                              validator: _bookRegistrationScreenController
                                  .formValidator.validate,
                              keyboardType: TextInputType.text),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextFormField(
                              theme: 'dark',
                              label: 'Toc',
                              controller: _tocController,
                              validator: _bookRegistrationScreenController
                                  .formValidator.validate,
                              keyboardType: TextInputType.text),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextFormField(
                              theme: 'dark',
                              label: 'Review Editorial',
                              controller: _editorialReviewsController,
                              validator: _bookRegistrationScreenController
                                  .formValidator.validate,
                              keyboardType: TextInputType.text),
                          const SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Expanded(child: SizedBox()),
                              Expanded(
                                child: SizedBox(
                                  height: 50,
                                  child: ValueListenableBuilder(
                                    valueListenable:
                                        _bookRegistrationScreenController
                                            .registerLoading,
                                    builder: (context, value, child) {
                                      return ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromRGBO(
                                              225, 23, 106, 1),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                        onPressed: () async {
                                          if (_registerBookFormKey.currentState!
                                              .validate()) {
                                            String request =
                                                await _bookRegistrationScreenController
                                                    .registerBook(
                                                        _titleController.text,
                                                        _authorIdController
                                                            .text,
                                                        _titleSlugController
                                                            .text,
                                                        _priceController.text,
                                                        _formatController.text,
                                                        _publisherController
                                                            .text,
                                                        _pubdateController.text,
                                                        _editionController.text,
                                                        _lexileController.text,
                                                        _pagesController.text,
                                                        _dimensionsController
                                                            .text,
                                                        _overviewController
                                                            .text,
                                                        _excerptController.text,
                                                        _synopsisController
                                                            .text,
                                                        _tocController.text,
                                                        _editorialReviewsController
                                                            .text);
                                            if (context.mounted) {
                                              return _responsePopup.showPopup(
                                                  context,
                                                  _bookRegistrationScreenController
                                                      .repositoryResponseMessage,
                                                  request);
                                            }
                                          }
                                        },
                                        child: value
                                            ? const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.black,
                                                ),
                                              )
                                            : const Text(
                                                'Cadastrar',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const Expanded(child: SizedBox()),
                            ],
                          ),
                        ],
                      ),
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
