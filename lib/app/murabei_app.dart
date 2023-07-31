import 'package:flutter/material.dart';
import 'package:murabei_frontend/app/routes.dart';

class MurabeiApp extends StatelessWidget {
  const MurabeiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: Routes.routes,
      initialRoute: '/login',
    );
  }
}
