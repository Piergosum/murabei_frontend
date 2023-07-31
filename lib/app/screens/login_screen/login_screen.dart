import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:murabei_frontend/app/screens/login_screen/widgets/custom_text_form_field.dart';
import 'package:murabei_frontend/app/screens/shared_widgets/response_popup.dart';

import 'controller/login_screen_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginScreenController _loginScreenController;
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();
  final ResponsePopup _responsePopup = ResponsePopup();

  @override
  void initState() {
    super.initState();
    _loginScreenController = LoginScreenController();
  }

  @override
  void dispose() {
    super.dispose();
    _loginScreenController.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const Expanded(child: SizedBox()),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                const Expanded(child: SizedBox()),
                Expanded(
                  flex: 3,
                  child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Hero(
                            tag: 'murabei logo',
                            child: Image.asset(
                              'images/murabei-logo.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned.fill(
                          left: 400,
                          child: ClipPath(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            clipper: OvalLeftBorderClipper(),
                            child: Container(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Positioned.fill(
                          left: 400,
                          child: Row(
                            children: [
                              const Expanded(child: SizedBox()),
                              Expanded(
                                flex: 2,
                                child: Form(
                                  key: _loginFormKey,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomTextFormField(
                                          theme: 'light',
                                          label: 'Usuário',
                                          controller: _userNameController,
                                          validator: _loginScreenController
                                              .formValidator.validate,
                                          keyboardType: TextInputType.text),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      CustomTextFormField(
                                          theme: 'light',
                                          label: 'Senha',
                                          controller: _passwordController,
                                          validator: _loginScreenController
                                              .formValidator.validate,
                                          keyboardType: TextInputType.text),
                                      const SizedBox(
                                        height: 50,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: SizedBox(
                                              height: 50,
                                              child: ValueListenableBuilder(
                                                valueListenable:
                                                    _loginScreenController
                                                        .loginLoading,
                                                builder:
                                                    (context, value, child) {
                                                  return ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          const Color.fromRGBO(
                                                              225, 23, 106, 1),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                      ),
                                                    ),
                                                    onPressed: () async {
                                                      if (_loginFormKey
                                                          .currentState!
                                                          .validate()) {
                                                        String request =
                                                            await _loginScreenController
                                                                .requestAuth(
                                                          _userNameController
                                                              .text,
                                                          _passwordController
                                                              .text,
                                                        );
                                                        if (request ==
                                                            'success') {
                                                          if (context.mounted) {
                                                            Navigator.pushNamed(
                                                                context,
                                                                '/pagina-inicial');
                                                          }
                                                        } else {
                                                          if (context.mounted) {
                                                            return _responsePopup
                                                                .showPopup(
                                                                    context,
                                                                    _loginScreenController
                                                                        .repositoryResponseMessage,
                                                                    request);
                                                          }
                                                        }
                                                      }
                                                    },
                                                    child: value
                                                        ? const Center(
                                                            child:
                                                                CircularProgressIndicator(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          )
                                                        : const Text(
                                                            'Entrar',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                  );
                                                },
                                              ),
                                            ),
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
                      ],
                    ),
                  ),
                ),
                const Expanded(child: SizedBox()),
              ],
            ),
          ),
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
